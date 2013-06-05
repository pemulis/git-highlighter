class GithubUserUpdate < ActiveRecord::Base
  require 'resque/errors'

  def self.queue
    :user_update
  end

  def self.perform(login, oauth_token)
    client = Octokit::Client.new(login: login, oauth_token: oauth_token)
    current_user = User.find_by_login(login)
    current_user.get_user_data(client)
    current_user.get_followed_users(client)
    current_user.get_starred_repos(client)
    current_user.get_recommendations(client)
    
    # include something that tells users#updating that the job is done


  rescue Resque::TermException
    Resque.enqueue(self, login, oauth_token)
  end
end
