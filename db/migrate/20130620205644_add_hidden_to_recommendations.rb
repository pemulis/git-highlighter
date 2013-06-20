class AddHiddenToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :hidden, :boolean, default: false 
  end
end
