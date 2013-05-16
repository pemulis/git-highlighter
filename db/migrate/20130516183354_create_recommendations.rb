class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.string :name
      t.integer :score

      t.timestamps
    end
  end
end
