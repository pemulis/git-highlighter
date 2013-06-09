class RenameColumnInRecommendations < ActiveRecord::Migration
  def change
    rename_column :recommendations, :type, :rec_type 
  end
end
