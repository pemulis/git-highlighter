class UsersController < ApplicationController
  def index
    render action: 'show' unless current_user.nil?
  end

  def show
    # TODO:
    #
    # * Analyze followed users' starred repos, as well as the users
    #   they themselves follow 
    # * Cache results of the analysis
    # * Show cached results if less than 24 hours old 
  end

  def update
    client = Octokit::Client.new(login: current_user.login, 
                                  oauth_token: session[:oauth_token])

    current_user.get_user_data(client)
    current_user.get_followed_users(client)
    current_user.get_starred_repos(client)
    current_user.save
    redirect_to root_url 
  end
end
