# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include UsersHelper

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'main'
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  filter_parameter_logging :password, :password_confirmation
  helper_method :logged_in?, :current_user, :current_user_session

  before_filter :set_locale, :check_language_change

  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]

    # set locale based on session or default
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def check_language_change
    redirect_to :back if params[:locale]
  end

  private
  def authorization_failed!
    flash[:error] = "You have no permission to perform this action"
    redirect_to(root_path)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def logged_in?
    current_user ? true : false
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end

  def require_admin
    unless current_user.admin?
      store_location
      flash[:notice] = "You must be be and administrator to perform this action"
      redirect_to login_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
