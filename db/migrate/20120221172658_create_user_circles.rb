class CreateUserCircles < ActiveRecord::Migration
  def change
    create_table :user_circles do |t|
      t.references :user
      t.references :circle

      t.timestamps
    end
  end
end
