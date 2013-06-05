class UsersController < ApplicationController
  def index
    render action: 'show' unless current_user.nil?
  end

  def show
  end

  def update
    login = current_user.login
    oauth_token = session[:oauth_token]
    Resque.enqueue(GithubUserUpdate, login, oauth_token)
    redirect_to action: 'updating' 
  end

  def updating
    # after the resque job finishes, and 
    # user recommendations are updated...
    # redirect_to root_url
  end
end
