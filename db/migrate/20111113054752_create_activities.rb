class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :group
      t.string   :title
      t.string   :pyname
      t.text     :description, :default => ""
      t.datetime :start_at
      t.datetime :end_at
      t.string   :location, :default => ""
      t.boolean  :public, :default => true
      t.integer  :status, :default => Constant::Approved
      t.string   :poster_file_name
      t.string   :poster_content_type
      t.integer  :poster_file_size
      t.datetime :poster_updated_at
      t.string   :banner_file_name
      t.string   :banner_content_type
      t.integer  :banner_file_size
      t.datetime :banner_updated_at
      t.integer  :points, :default => 0
      t.boolean  :delta, :default => true, :null => false
      t.text     :announcement
      t.integer  :boss_id

      t.timestamps
    end
    add_index :activities, :group_id
  end
end
