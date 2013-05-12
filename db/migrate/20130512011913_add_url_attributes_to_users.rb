class AddUrlAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followers_url, :string
    add_column :users, :following_url, :string
    add_column :users, :starred_url, :string
    add_column :users, :subscriptions_url, :string
    add_column :users, :organizations_url, :string
  end
end
