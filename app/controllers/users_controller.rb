class UsersController < ApplicationController
  def index
    @uri = "http://#{request.host+request.fullpath}"
    @params = Rack::Utils.parse_query URI(@uri).query
    @code = @params["code"]

    if @code.nil?
      render 
    else
      RestClient.post "https://github.com/login/oauth/access_token", client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: "#{@code}"

      # TODO:
      # * Grab access token from response
      # * Use access token to show correct user
    end
  end

  def new
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV["CLIENT_ID"]}"
  end

  def show 
    # TODO:
    # * Create database entry for user if one does not exist
    # * Get user's followers
    # * Get user's followers' followers
    # * Analyze 1st and 2nd degree followers' starred repos to 
    #   make recommendations
    # * Cache results of the analysis
    # * Show cached results if less than 24 hours old 
  end
end
