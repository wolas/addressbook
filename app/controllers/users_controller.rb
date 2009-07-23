class UsersController < ApplicationController
  before_filter :require_admin, :only => [:destroy]
  before_filter :require_current_user, :only => [:edit, :update]

  def search
    all = translate('txt.all')
    params[:company] ||= all
    users = params[:company].eql?(all) ? User : Company.find(params[:company]).users
    users = users.all :order => 'surname ASC', :conditions => ["name LIKE ? OR surname LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"], :include => :company
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'list', :locals => {:users => users, :show_company => params[:company].eql?('All')}})
  end


  def index
    @users = User.all :select => User::ATTS, :order => 'surname ASC', :include => :company
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if params[:user][:admin].eql?('0')
      @user.generate_password
      @user.generate_login
    end

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

  end

  def update
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

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'User was succesfully deleted.'
    redirect_to root_url
  end

  def require_current_user
    @user = User.find(params[:id])
    if current_user != @user
      flash[:error] = "You cannot edit this persons details"
      redirect_back_or_default root_url
    end
  end
end
