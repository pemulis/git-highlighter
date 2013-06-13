# == Schema Information
#
# Table name: followed_users
#
#  id          :integer          not null, primary key
#  login       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  avatar_url  :string(255)
#  gravatar_id :string(255)
#

class FollowedUser < ActiveRecord::Base
  has_and_belongs_to_many :users
end
