class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]
  before_filter :require_admin, :only => [:index]

  def search
    users = User.all :conditions => ["login LIKE ? OR surname LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"]
    render :partial => 'users/list', :locals => {:users => users}
  end

  def index
    @users = User.all :order => 'login ASC'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : @current_user
    return authorization_failed! if @user.company != current_user.company and !admin?
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
