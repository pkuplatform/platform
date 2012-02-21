class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.integer  :status, :default => 4
      t.string   :name
      t.integer  :unread_message_count
      t.string   :pyname
      t.string   :nickname
      t.integer  :gender, :default => 1
      t.string   :student_id
      t.string   :phone
      t.integer  :points, :default => 0
      t.text     :description, :default => ""
      t.string   :avatar_file_name
      t.string   :avatar_content_type
      t.integer  :avatar_file_size
      t.datetime :avatar_updated_at
      t.boolean  :delta, :default => true, :null => false

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
