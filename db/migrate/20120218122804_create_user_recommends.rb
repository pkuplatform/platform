class CreateUserRecommends < ActiveRecord::Migration
  def change
    create_table :user_recommends do |t|
      t.references :user
      t.references :recommendable, :polymorphic => true
      t.float :value, :default => 0

      t.timestamps
    end
    add_index :user_recommends, :user_id
    add_index :user_recommends, [:recommendable_id, :recommendable_type]
  end
end
