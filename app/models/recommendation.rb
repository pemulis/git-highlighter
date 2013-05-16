# == Schema Information
#
# Table name: recommendations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recommendation < ActiveRecord::Base
  belongs_to :user
end
