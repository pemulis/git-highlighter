class UsersController < ApplicationController
  def index
    render action: 'show' unless current_user.nil?
  end

  def show
  end

  def update
    oauth_token = session[:oauth_token]
    login = current_user.login
    user_id = current_user.id
    Resque.enqueue(GithubUserUpdate, oauth_token, login, user_id)
    redirect_to action: 'updating' 
  end

  def updating
    # after the resque job finishes, and 
    # user recommendations are updated...
    # redirect_to root_url
  end
end
