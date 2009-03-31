class RolesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def index
    @users = User.all
  end

  def update_roles
    user = User.find params[:id]
    user.update_attributes :admin => params[:admin]
  end
end
