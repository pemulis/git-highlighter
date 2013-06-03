class UsersController < ApplicationController
  def index
    render action: 'show' unless current_user.nil?
  end

  def show
  end

  def update
    client = Octokit::Client.new(login: current_user.login, 
                                 oauth_token: session[:oauth_token])
    user_id = current_user.id

    Resque.enqueue(GithubUserUpdate, client, user_id)
    redirect_to action: 'updating' 
  end

  def updating
    # after the resque job finishes, and 
    # user recommendations are updated...
    # redirect_to root_url
  end
end
