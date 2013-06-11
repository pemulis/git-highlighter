class GithubUserUpdate < ActiveRecord::Base
  require 'resque/errors'
  include Resque::Plugins::Status

  @queue = :user_update

  def perform
    login = options['login']
    oauth_token = options['oauth_token']
    client = Octokit::Client.new(login: login, oauth_token: oauth_token)
    current_user = User.find_by_login(login)
    current_user.get_user_data(client)
    current_user.get_followed_users(client)
    current_user.get_starred_repos(client)
    current_user.get_recommendations(client)
    
    # include something that tells users#updating that the job is done
    completed

  rescue Resque::TermException
    update_job_id = GithubUserUpdate.create(login: login, oauth_token: oauth_token)
    session[:update_job_id] = update_job_id
    # Resque.enqueue(GithubUserUpdate, login, oauth_token)
  end
end
