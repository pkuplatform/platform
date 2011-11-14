class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.integer :status
      t.string :name
      t.string :nickname
      t.integer :gender
      t.string :student_id
      t.string :phone
      t.integer :points
      t.text :description
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
