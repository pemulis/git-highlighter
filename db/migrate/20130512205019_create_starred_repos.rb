class CreateStarredRepos < ActiveRecord::Migration
  def change
    create_table :starred_repos do |t|
      t.integer :github_id
      t.string :owner_login
      t.integer :owner_github_id
      t.string :owner_avatar_url
      t.string :owner_gravatar_id
      t.string :owner_url
      t.string :name
      t.string :full_name
      t.string :description
      t.boolean :private
      t.boolean :fork
      t.string :url
      t.string :html_url
      t.string :clone_url
      t.string :git_url
      t.string :ssh_url
      t.string :svn_url
      t.string :mirror_url
      t.string :homepage
      t.string :language
      t.integer :forks
      t.integer :forks_count
      t.integer :watchers
      t.integer :watchers_count
      t.integer :size
      t.string :master_branch
      t.integer :open_issues
      t.string :pushed_at
      t.string :github_created_at
      t.string :github_updated_at

      t.timestamps
    end
  end
end
