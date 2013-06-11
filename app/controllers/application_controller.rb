class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  include Resque::Plugins::Status

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
