class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.references :user
      t.references :activity
      t.integer :status

      t.timestamps
    end
    add_index :user_activities, :user_id
    add_index :user_activities, :activity_id
  end
end
