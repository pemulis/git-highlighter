class GithubUserUpdate < ActiveRecord::Base
  require 'resque/errors'

  def self.queue
    :user_update
  end

  def self.perform(login, oauth_token)
    puts 'foo'
    client = Octokit::Client.new(login: login, oauth_token: oauth_token)
    puts 'bar'
    current_user = User.find_by_login(login)
    puts 'baz'
    current_user.get_user_data(client)
    puts 'quz?'
    current_user.get_followed_users(client)
    puts 'uhh'
    current_user.get_starred_repos(client)
    puts 'some other thing'
    current_user.get_recommendations(client)
    puts 'success???'
    
    # include something that tells users#updating that the job is done


  rescue Resque::TermException
    Resque.enqueue(GithubUserUpdate, login, oauth_token)
  end
end
