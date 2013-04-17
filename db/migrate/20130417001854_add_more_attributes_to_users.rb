class AddMoreAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :github_id, :integer
    add_column :users, :avatar_url, :string
    add_column :users, :gravatar_id, :string
    add_column :users, :url, :string
    add_column :users, :company, :string
    add_column :users, :blog, :string
    add_column :users, :location, :string
    add_column :users, :email, :string
    add_column :users, :hireable, :boolean
    add_column :users, :bio, :string
    add_column :users, :public_repos, :integer
    add_column :users, :public_gists, :integer
    add_column :users, :followers, :integer
    add_column :users, :following, :integer
    add_column :users, :html_url, :string
    add_column :users, :github_profile_created_at, :string
    add_column :users, :type, :string
  end
end
