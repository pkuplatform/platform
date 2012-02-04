class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :group
      t.string   :title
      t.text     :description
      t.datetime :start_at
      t.datetime :end_at
      t.string   :location
      t.boolean  :public
      t.integer  :status
      t.string   :poster_file_name
      t.string   :poster_content_type
      t.integer  :poster_file_size
      t.datetime :poster_updated_at
      t.string   :banner_file_name
      t.string   :banner_content_type
      t.integer  :banner_file_size
      t.datetime :banner_updated_at
      t.integer  :points
      t.boolean  :delta, :default => true, :null => false

      t.timestamps
    end
    add_index :activities, :group_id
  end
end
