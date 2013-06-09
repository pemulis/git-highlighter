# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  login                     :string(255)
#  github_id                 :integer
#  avatar_url                :string(255)
#  gravatar_id               :string(255)
#  url                       :string(255)
#  company                   :string(255)
#  blog                      :string(255)
#  location                  :string(255)
#  email                     :string(255)
#  hireable                  :boolean
#  bio                       :text
#  public_repos              :integer
#  public_gists              :integer
#  followers                 :integer
#  following                 :integer
#  html_url                  :string(255)
#  github_profile_created_at :string(255)
#  type                      :string(255)
#  slug                      :string(255)
#  followers_url             :string(255)
#  following_url             :string(255)
#  starred_url               :string(255)
#  subscriptions_url         :string(255)
#  organizations_url         :string(255)
#

class User < ActiveRecord::Base
  has_and_belongs_to_many :followed_users, uniq: true
  has_and_belongs_to_many :starred_repos, uniq: true
  has_many :recommendations, dependent: :destroy
  attr_accessible :login

  extend FriendlyId
  friendly_id :login, use: :slugged



  # Class Methods, Woohoo!

  def self.create_with_omniauth(auth)
    create! do |user|
      user.login = auth['extra']['raw_info']['login']
      user.github_id = auth['extra']['raw_info']['id']
      user.avatar_url = auth['extra']['raw_info']['avatar_url'] 
      user.gravatar_id = auth['extra']['raw_info']['gravatar_id']
      user.url = auth['extra']['raw_info']['url']
      user.company = auth['extra']['raw_info']['company']
      user.blog = auth['extra']['raw_info']['blog']
      user.location = auth['extra']['raw_info']['location']
      user.email = auth['extra']['raw_info']['email']
      user.hireable = auth['extra']['raw_info']['hireable']
      user.bio = auth['extra']['raw_info']['bio']
      user.public_repos = auth['extra']['raw_info']['public_repos']
      user.public_gists = auth['extra']['raw_info']['public_gists']
      user.followers = auth['extra']['raw_info']['followers']
      user.following = auth['extra']['raw_info']['following']
      user.html_url = auth['extra']['raw_info']['html_url']
      user.followers_url = auth['extra']['raw_info']['followers_url']
      user.following_url = auth['extra']['raw_info']['following_url']
      user.starred_url = auth['extra']['raw_info']['starred_url']
      user.subscriptions_url = auth['extra']['raw_info']['subscriptions_url']
      user.organizations_url = auth['extra']['raw_info']['organizations_url']
      user.github_profile_created_at = auth['extra']['raw_info']['created_at']
      user.type = auth['extra']['raw_info']['type']
    end
  end




  # Instance Methods (yesss...)

  def get_user_data(client, user=self)
    # Octokit client grabs data from Github
    o = client.user(user.login)

    # The current user is updated in our database
    user.github_id = o.id
    user.avatar_url = o.avatar_url
    user.gravatar_id = o.gravatar_id
    user.url = o.url
    user.company = o.company
    user.blog = o.blog
    user.location = o.location
    user.email = o.email
    user.hireable = o.hireable
    user.bio = o.bio
    user.public_repos = o.public_repos
    user.public_gists = o.public_gists
    user.followers = o.followers
    user.following = o.following
    user.html_url = o.html_url
    user.github_profile_created_at = o.created_at
    user.type = o.type
    user.followers_url = o.followers_url
    user.following_url = o.following_url
    user.starred_url = o.starred_url
    user.subscriptions_url = o.subscriptions_url
    user.organizations_url = o.organizations_url

    user.save
  end

  def get_followed_users(client, user=self)
    # Octokit client grabs array of followed users
    array = client.following(user.login)
    
    # This object is used to create follower-followed associations
    association = user.followed_users

    array.each do |f|
      # Add followed users to the FollowedUsers table
      followed = FollowedUser.find_or_create_by_login(f.login)
      followed.save

      # Create the association with the user
      association << followed unless association.exists?(followed) 
    end
  end

  def get_starred_repos(client, user=self)
    # Octokit client grabs array of starred repos
    array = client.starred(user.login)

    # This object is used to create User-StarredRepo associations
    association = user.starred_repos

    array.each do |a|
      starred = StarredRepo.find_or_create_by_full_name(a.full_name)
      starred.get_repo_data(client)
      starred.save

      # Create the association with the user
      association << starred unless association.exists?(starred)  
    end
  end

  def get_recommendations(client, user=self)
    # Find people the user should follow
    second_degree_followed = []
    followed = user.followed_users
    followed.each do |f|
      new_user = User.find_or_create_by_login(f.login)
      new_user.save
      new_user.get_followed_users(client)
      new_user.followed_users.each do |n|
        second_degree_followed << n.login
      end
    end
    
    # Find repos the user should look at
    second_degree_starred = []
    followed = user.followed_users
    followed.each do |f|
      followed_user = User.find_by_login(f.login)
      followed_user.get_starred_repos(client)
      followed_user.starred_repos.each do |s|
        second_degree_starred << s.full_name
      end
    end

    # Score and save the recommendations
    recs = second_degree_followed + second_degree_starred

    scored = recs.each_with_object(Hash.new(0)) do |r, h|
      h[r] += 1
    end

    scored.each do |k, v|
      rec = user.recommendations.find_or_create_by_name(k)
      rec.score = v
      if /*\/*/.match(k)
        rec.type = "repo"
        repo = StarredRepo.find_by_full_name(k)
        rec.description = repo.description
      else
        rec.type = "user"
      end
      rec.save
    end
  end
end
