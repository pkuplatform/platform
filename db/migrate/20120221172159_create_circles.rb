class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.references :owner, :polymorphic => true
      t.integer :status, :default => 0
      t.integer :mode, :default => 0740 #check constant.rb for information
      t.string :name

      t.timestamps
    end
  end
end
