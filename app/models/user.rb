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
#  bio                       :string(255)
#  public_repos              :integer
#  public_gists              :integer
#  followers                 :integer
#  following                 :integer
#  joined_github_date        :string(255)
#  html_url                  :string(255)
#  type                      :string(255)
#

class User < ActiveRecord::Base
  has_and_belongs_to_many :followed_users, uniq: true
end
