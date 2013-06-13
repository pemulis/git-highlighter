class AddAtrributesToFollowedUser < ActiveRecord::Migration
  def change
    add_column :followed_users, :avatar_url, :string
    add_column :followed_users, :gravatar_id, :string
  end
end
