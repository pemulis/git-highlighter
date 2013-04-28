class RemoveUserIdFromFollowedUser < ActiveRecord::Migration
  def change
    change_table :followed_users do |t|
      t.remove :user_id
    end
  end
end
