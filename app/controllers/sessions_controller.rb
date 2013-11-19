class SessionsController < ApplicationController

  # If in development environment, skip CSRF token checking
  # for the developer strategy
  skip_before_filter :verify_authenticity_token if Rails.env.development?

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to authenticated_home_url, notice: 'Signed in.'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed Out'
  end
end
