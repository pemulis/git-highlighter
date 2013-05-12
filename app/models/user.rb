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

      # Create the associations in the FollowedUsersUsers 
      association << followed unless association.exists?(followed) 
    end
  end

  def get_starred_repos(client, user=self)
    # Octokit client grabs array of starred repos
    array = client.starred(user.login)


  end

  def get_recommendations(client, user=self)
    # Create array of 2nd-degree followed users 

    # Create array of starred repos from 1st- and 2nd-degree followed 
    # users

    # Tally up the totals and sort recommendations

  end
end
