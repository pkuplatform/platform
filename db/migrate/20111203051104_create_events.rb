class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :subject_type
      t.integer :subject_id
      t.string :action
      t.string :object_type
      t.integer :object_id
      t.boolean :processed, :default => false

      t.timestamps
    end
  end
end
