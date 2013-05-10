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

    # Take care of OAuth stuff
    #
    if @token.nil?
      if @code = params[:code]
        @token = get_oauth_token(@code)
      else
        get_code
      end
    end

    # Initialize the Octokit client
    #
    @client = Octokit::Client.new(login: @user.login, 
                                  oauth_token: @token)

    @octokit = @client.user(@user.login)
    get_user_data(@user, @octokit)

    @followed = @client.following(@user.login)

    get_followed_users(@user, @followed, @client)
    
    if @user.save
      cookies[:login] = @user.login
      redirect_to(@user, 
                  notice: 'User recommendations created or updated.')
    else
      render action: 'new'
    end
  end

  def show
    @user = User.find(params[:id])

    # TODO:
    #
    # * Analyze followed users' starred repos, as well as the users
    #   they themselves follow 
    # * Cache results of the analysis
    # * Show cached results if less than 24 hours old 
  end



  # Helper Methods
  #
  def get_code
    url = "https://github.com/login/oauth/authorize?client_id=#{ENV['CLIENT_ID']}"
    redirect_to url and return 
  end

  def get_oauth_token(code)
    url = "https://github.com/login/oauth/access_token"
    resp = RestClient.post url, client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"], code: code
    token = JSON.parse(resp)["access_token"]
  end

  def get_user_data(u, o)
    # u - the user object
    # o - the octokit object
    #
    u.github_id = o.id
    u.avatar_url = o.avatar_url
    u.gravatar_id = o.gravatar_id
    u.url = o.url
    u.company = o.company
    u.blog = o.blog
    u.location = o.location
    u.email = o.email
    u.hireable = o.hireable
    u.bio = o.bio
    u.public_repos = o.public_repos
    u.public_gists = o.public_gists
    u.followers = o.followers
    u.following = o.following
    u.html_url = o.html_url
    u.github_profile_created_at = o.created_at
    u.type = o.type
  end

  def get_followed_users(user, array, client)
    # user - user object
    # array - octokit-generated array of followed users
    # client - octokit client
    #
    array.each do |f|
      # Add 1st-degree followed users to the Users table 
      # (why not!)
      #
      @new_user = User.find_or_create_by_login(f.login)
      @new_user_octokit = @client.user(f.login)
      get_user_data(@new_user, @new_user_octokit)
      @new_user.save

      # Add 1st-degree followed users to the FollowedUsers table
      #
      @followed = FollowedUser.find_or_create_by_login(f.login)
      @followed.save

      # Create the association in the FollowedUsersUsers table
      #
      @association = user.followed_users
      @association << @followed unless @association.exists?(@followed) 
    end
  end

end
