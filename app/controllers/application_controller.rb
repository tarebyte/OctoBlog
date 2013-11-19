class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "content"

  rescue_from CanCan::AccessDenied do
    # raise a 404 error when access is denied
    raise ActionController::RoutingError.new('Not Found')
  end
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
