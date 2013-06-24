class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :status_hash

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def update_status
    @status_hash = Resque::Plugins::Status::Hash.get(session[:update_job_id]) if session[:update_job_id]
  end
end
