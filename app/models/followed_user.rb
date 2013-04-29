# == Schema Information
#
# Table name: followed_users
#
#  id         :integer          not null, primary key
#  login      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FollowedUser < ActiveRecord::Base
  belongs_to :users
end
