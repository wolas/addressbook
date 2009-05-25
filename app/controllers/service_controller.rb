class ServiceController < ApplicationController
  def index
  end

  def edit
    @user = User.find_by_access_code params[:access_code]
  end

  def update

  end

  def send_access
    user = User.find_by_email(params[:email])
    if user
      user.update_attributes :access_code => User.generate_access_code
      Notifier.deliver_send_access(user)
      flash[:notice] = "An email has been sent to #{params[:email]}"
    else
      flash[:error] = "No user with email #{params[:email]}"
    end

    redirect_to :action => :index
  end

  def external_edit
    @user = User.find_by_access_code params[:access_code]
    render :action => :edit
  end

end
