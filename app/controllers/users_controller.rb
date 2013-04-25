class UsersController < ApplicationController
  def index
    @uri = "http://#{request.host+request.fullpath}"
    @params = Rack::Utils.parse_query URI(@uri).query
    @code = @params["code"]

    unless @code.nil?
      
      resp = RestClient.post "https://github.com/login/oauth/access_token", client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: "#{@code}", accept: :json
      
      @token = resp["access_token"]
      @client = Octokit::Client.new(oauth_token: @token)
      @user = @client.user()
      @following = @client.following(@user)
      @user2 = Octokit.user("pemulis")
      @following2 = Octokit.following("pemulis")

      # TODO:
      # X Grab access token from response
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
