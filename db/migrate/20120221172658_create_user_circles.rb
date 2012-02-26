class CreateUserCircles < ActiveRecord::Migration
  def change
    create_table :user_circles do |t|
      t.references :user
      t.references :circle

      t.timestamps
    end
    add_index :user_circles, :user_id
    add_index :user_circles, :circle_id
  end
end
