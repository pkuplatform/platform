class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :album
      t.references :user
      t.string :remark
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
    add_index :pictures, :album_id
    add_index :pictures, :user_id
  end
end
