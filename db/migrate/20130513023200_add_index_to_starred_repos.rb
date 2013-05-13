class AddIndexToStarredRepos < ActiveRecord::Migration
  def change
    add_index :starred_repos, :full_name
  end
end
