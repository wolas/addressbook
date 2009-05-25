class ServiceController < ApplicationController
  def index
  end

  def edit
    @user = User.find_by_access_code params[:access_code]

    unless @user
      flash[:error] = 'Your access code has expired or has already been used. Retry the process please.'
      redirect_to :action => :index
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])

      @user.update_attributes :access_code => nil

      flash[:notice] = "Your account was updated succesfully!"
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  def send_access
    user = User.find_by_email(params[:email])
    if user
      user.update_attributes :access_code => User.generate_access_code
      Notifier.deliver_send_access(user)
      redirect_to :action => :thank_you
    else
      flash[:error] = "No user with email #{params[:email]}"
      redirect_to :action => :index
    end
  end

  def thank_you

  end
end
