class UsersFollowedUsers < ActiveRecord::Migration
  def change
   create_table :users_followed_users, :id => false do |t|
     t.references :user, null: false
     t.references :followed_user, null: false
   end 

   add_index(:users_followed_users, [:user_id, :followed_user_id], unique: true)
  end
end
