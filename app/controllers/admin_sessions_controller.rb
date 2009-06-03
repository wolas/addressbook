class AdminSessionsController < ApplicationController
  before_filter :require_user, :only => :destroy


  def new
    @admin_session = AdminSession.new
  end

  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      redirect_back_or_default root_url
    else
      render :action => :new
    end
  end

  def destroy
    current_admin_session.destroy
    redirect_back_or_default root_url
  end

  def secure?
    false
  end
end
