class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(cookies.encrypted[:user_id]) if cookies[:user_id]
  end

end
