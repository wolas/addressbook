class RolesController < ApplicationController

  def search
    all = translate('txt.all')
    params[:company] ||= all
    users = params[:company].eql?(all) ? User : Company.find(params[:company]).users
    users = users.all :order => 'surname ASC', :conditions => ["name LIKE ? OR surname LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"], :include => :company
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'list', :locals => {:users => users, :show_company => params[:company].eql?('All')}})
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find params[:id]

    @user.update_attributes(params[:user])
    flash[:notice] = "#{@user.full_name} made admin"
    redirect_to roles_path
  end
end
