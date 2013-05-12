class CreateStarredReposUsers < ActiveRecord::Migration
  def change
    create_table :starred_repos_users, :id => false do |t|
      t.references :user, null: false
      t.references :starred_repo, null: false
    end

    add_index(:starred_repos_users, [:starred_repo_id, :user_id], unique: true)
  end
end
