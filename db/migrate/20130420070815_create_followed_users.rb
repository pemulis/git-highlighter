class CreateFollowedUsers < ActiveRecord::Migration
  def change
    create_table :followed_users do |t|
      t.string :login

      t.timestamps
    end
  end
end
