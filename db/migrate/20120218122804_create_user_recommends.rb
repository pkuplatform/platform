class CreateUserRecommends < ActiveRecord::Migration
  def change
    create_table :user_recommends do |t|
      t.references :user
      t.integer :recommend

      t.timestamps
    end
    add_index :user_recommends, :user_id
  end
end
