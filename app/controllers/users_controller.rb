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

    # Github API calls incoming!
    #
    @octokit = Octokit.user(@user.login)
    get_user_data(@user, @octokit)

    @following = Octokit.following(@user.login)
    get_followed_users(@user, @following) # Figure out how to do this
    
    if @user.save
      # Add extra check to make sure followed users saved correctly
      #
      cookies[:login] = @user.login
      redirect_to(@user, 
                  notice: 'User recommendations created or updated.')
    else
      render action: 'new'
    end

    # TODO:
    #
    # * Get user's followers
    # * Get user's followers' followers
  end

  def show
    @user = User.find(params[:id])

    # TODO:
    #
    # * Analyze 1st and 2nd degree followers' starred repos to 
    #   make recommendations
    # * Cache results of the analysis
    # * Show cached results if less than 24 hours old 
  end



  # Helper Methods
  #
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

  def get_followed_users(u, f)
    # u - the user object
    # f - the octokit following object
    #
    # There should be some code here!
  end

end
