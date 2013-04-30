class RenameUsersFollowedUsersToFollowedUsersUsers < ActiveRecord::Migration
  def change 
    rename_table :users_followed_users, :followed_users_users
  end
end
