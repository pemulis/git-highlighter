class GithubUserUpdate < ActiveRecord::Base
  extend HerokuAutoScaler::AutoScaling

  def self.queue
    # Is this going to be the ENV['QUEUE'] variable?
    :my_queue
  end

  def self.perform(*args)
    # GitHub client should be passed as an arg
    # All of the API-intensive update stuff should be done here
  end
end
