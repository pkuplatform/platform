class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.integer :liking_id
      t.integer :liked_id

      t.timestamps
    end

    add_index :user_relations, :liking_id 
    add_index :user_relations, :liked_id
    add_index :user_relations, [:liking_id, :liked_id], :unique => true
  end
end
