class UsersController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :edit]

  def search
    params[:company] ||= "All"
    users = params[:company].eql?("All") ? User : Company.find(params[:company]).users
    users = users.all :conditions => ["name LIKE ? OR surname LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"]
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'list', :locals => {:users => users}})
  end

  def get_access
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

    redirect_to :action => :get_access
  end

  def index
    @users = User.all :order => 'login ASC'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.generate_password if params[:user][:admin].eql?('0')
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default @user
    else
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = @current_user
  end

  def external_edit
    @user = User.find_by_access_code params[:access_code]
    render :action => :edit
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:admin].eql?('0')
      params[:user].delete :password_confirmation
      params[:user].delete :password
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to @user
    else
      render :action => :edit
    end
  end
end
