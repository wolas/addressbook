class RolesController < ApplicationController
  before_filter :require_admin, :except => [:search]

  def search
    params[:company] ||= "All"
    users = params[:company].eql?("All") ? User : Company.find(params[:company]).users
    users = users.all :conditions => ["name LIKE ? OR surname LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"]
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'roles/list', :locals => {:users => users}})
  end

  def index
    @users = User.all
  end

  def update_roles
    user = User.find params[:id]
    user.update_attributes :admin => params[:admin]
  end
end
