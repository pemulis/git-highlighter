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

require 'spec_helper'

describe FollowedUser do
  pending "add some examples to (or delete) #{__FILE__}"
end
