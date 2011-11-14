class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :group
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.references :location
      t.boolean :public
      t.integer :status
      t.string :poster_file_name
      t.string :poster_content_type
      t.integer :poster_file_size
      t.datetime :poster_updated_at
      t.integer :points

      t.timestamps
    end
    add_index :activities, :group_id
    add_index :activities, :location_id
  end
end
