class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.references :owner, :polymorphic => true
      t.integer :status, :default => 0
      t.boolean :public, :default => true
      t.string :name

      t.timestamps
    end
  end
end
