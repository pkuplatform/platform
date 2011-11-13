class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :user
      t.references :group
      t.integer :status

      t.timestamps
    end
    add_index :user_groups, :group_id
    add_index :user_groups, :user_id
  end
end
