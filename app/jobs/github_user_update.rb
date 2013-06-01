class GithubUserUpdate < ActiveRecord::Base
  # for worker scaling
  extend HerokuAutoScaler::AutoScaling 
  # for the current_user helper method
  extend ApplicationController

  def self.queue
    :user_update
  end

  def self.perform(client)
    current_user.get_user_data(client)
    current_user.get_followed_users(client)
    current_user.get_starred_repos(client)
    current_user.get_recommendations(client)

    current_user.save
    # include something that tells users#updating that the job is done
  end
end
