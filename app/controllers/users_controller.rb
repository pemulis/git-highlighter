class UsersController < ApplicationController
  def index
    render action: 'show' unless current_user.nil?
  end

  def show
  end

  def update
    if session[:update_job_id].nil? or update_status == 100
      login = current_user.login
      oauth_token = session[:oauth_token]
      update_job_id = GithubUserUpdate.create(login: login, oauth_token: oauth_token)
      session[:update_job_id] = update_job_id
    end

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js {}
    end
  end
end
