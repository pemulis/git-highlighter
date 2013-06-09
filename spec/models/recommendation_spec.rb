# == Schema Information
#
# Table name: recommendations
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rec_type    :string(255)
#  description :text
#

require 'spec_helper'

describe Recommendation do
  pending "add some examples to (or delete) #{__FILE__}"
end
