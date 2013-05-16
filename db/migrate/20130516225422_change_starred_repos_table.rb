class ChangeStarredReposTable < ActiveRecord::Migration
  def change
    change_column :starred_repos, :description, :text 
  end
end
