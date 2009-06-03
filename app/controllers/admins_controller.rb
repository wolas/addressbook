class AdminsController < ApplicationController
  before_filter :require_admin

  # GET /admins
  def index
    @users = User.all :include => :admin
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  def create
    @admin = Admin.new(params[:admin])

    if @admin.save
      flash[:notice] = 'Admin was successfully created.'
      redirect_to admins_url
    else
      render :action => "new"
    end
  end

  # PUT /admins/1
  def update
    @admin = Admin.find(params[:id])

    if @admin.update_attributes(params[:admin])
      flash[:notice] = 'Admin was successfully updated.'
      redirect_to admins_url
    else
      render :action => "edit"
    end
  end

  # DELETE /admins/1
  def destroy
    Admin.find(params[:id]).destroy
    redirect_to(admins_url)
  end
end
