class UsersController < ApplicationController
  def index
    render action: 'show' unless current_user.nil?
  end

  def show
  end

  def update
    login = current_user.login
    oauth_token = session[:oauth_token]
    update_job_id = GithubUserUpdate.create(login: login, oauth_token: oauth_token)
    session[:update_job_id] = update_job_id
    # Resque.enqueue(GithubUserUpdate, login, oauth_token)
    redirect_to action: 'updating'
  end

  def updating
    # while status = Resque::Plugins::Status::Hash.get(session[:update_job_id]) and !status.completed? and !status.failed?
    #   sleep 1
    # end
  end
end
