class UsersController < ApplicationController
  def new 
    @user = User.new

    # TODO:
    #
    # * Create nonspecific OAuth token for higher API rate limit
    # * Use username entered to show correct user
  end

  def create
  end

  def show
    # TODO:
    #
    # * Create database entry for user if one does not exist
    # * Get user's followers
    # * Get user's followers' followers
    # * Analyze 1st and 2nd degree followers' starred repos to 
    #   make recommendations
    # * Cache results of the analysis
    # * Show cached results if less than 24 hours old 
    # * NOTE: How much of this should take place in the model?
  end
end
