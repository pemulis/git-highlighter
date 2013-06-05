class GithubUserUpdate < ActiveRecord::Base
  # for worker scaling
  extend HerokuAutoScaler::AutoScaling

  def self.queue
    :user_update
  end

  def self.perform(oauth_token, login, user_id)
    client = Octokit::Client.new(login: login, oauth_token: oauth_token)
    current_user = User.find(user_id)
    current_user.get_user_data(client)
    current_user.get_followed_users(client)
    current_user.get_starred_repos(client)
    current_user.get_recommendations(client)

    current_user.save
    # include something that tells users#updating that the job is done
  end
end
