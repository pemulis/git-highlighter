class GithubUserUpdate < ActiveRecord::Base
  # I think that I may need to modify the job so that it doesn't use 
  # the current_user method. I don't think it has access to session 
  # methods, since it inherits from ActiveRecord::Base and not 
  # ApplicationController.
  #
  # It seems like I would still need a user object of some sort, so 
  # that I can save. Or perhaps it sends messages to a user object 
  # in the users#updating action, and they are saved there?
  #
  # In that case, I may need to split this into several different 
  # jobs, each handling a particular set of GitHub API calls.
  #
  # But how would I handle the get_recommendations method, which 
  # involves lots of heavy processing, but no external API calls? For 
  # that matter, get_starred_repos and get_followed_users both 
  # involve iterating through an array, and saving newly created 
  # instances of FollowedUser and Starred Repo. All of these need to 
  # be addressed in background job, too, since the Heroku web process 
  # will time out before the action is completed.
  #
  # No matter what, it appears I need to have model instances inside 
  # the Resque job. But how?
  #
  # "When I need to work with ActiveRecords in Resque, I just pass their ids across and re-query them from the database."
  # from: http://rubylearning.com/blog/2010/11/08/do-you-know-resque/
  #
  # Also learned there: Arguments passed to Resque are serialized as JSON.

  # for worker scaling
  extend HerokuAutoScaler::AutoScaling

  def self.queue
    :user_update
  end

  def self.perform(client, user_id)
    @current_user = User.find(user_id)
    current_user.get_user_data(client)
    current_user.get_followed_users(client)
    current_user.get_starred_repos(client)
    current_user.get_recommendations(client)

    current_user.save
    # include something that tells users#updating that the job is done
  end
end
