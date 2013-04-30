class UsersController < ApplicationController
  def index
    @user = User.find_by_login(cookies[:login])

    if @user.nil?
      redirect_to action: 'new'
    else
      render action: 'show'
    end
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.find_or_create_by_login(params[:user][:login])
    
    if @user.save
      cookies[:login] = @user.login
      redirect_to(@user, 
                  notice: 'User recommendations created or updated.')
    else
      render action: 'new'
    end

    # TODO:
    #
    # * All Github API calls should happen here
    # * Create database entry for user if one does not exist
    # * Get user's followers
    # * Get user's followers' followers
  end

  def show
    @user = User.find(params[:id])

    # TODO:
    #
    # * User username from #new to show correct user
    # * Analyze 1st and 2nd degree followers' starred repos to 
    #   make recommendations
    # * Cache results of the analysis
    # * Show cached results if less than 24 hours old 
  end
end
