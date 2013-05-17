class AddColumnTypeAndDescriptionToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :type, :string
    add_column :recommendations, :description, :text
  end
end
