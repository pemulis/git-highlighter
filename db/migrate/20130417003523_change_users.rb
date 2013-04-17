class ChangeUsers < ActiveRecord::Migration
  def change 
    change_column :users, :github_profile_created_at, :datetime
  end
end
