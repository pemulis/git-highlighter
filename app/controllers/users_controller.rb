class UsersController < ApplicationController
  def index
    redirect_to current_user unless current_user.nil?
  end

  def show
    # update_status = status_hash.pct_complete unless status_hash.nil?
    update_status = '25'
  end

  def update
    login = current_user.login
    oauth_token = session[:oauth_token]
    update_job_id = GithubUserUpdate.create(login: login, oauth_token: oauth_token)
    session[:update_job_id] = update_job_id
    redirect_to root_url
  end
end
