class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :update_status

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def update_status
    hash = Resque::Plugins::Status::Hash.get(session[:update_job_id])
    @update_status = hash.pct_complete unless hash.nil?
  end
end
