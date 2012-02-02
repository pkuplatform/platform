class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :category
      t.string :name
      t.string :slogan
      t.text :introduction
      t.text :description
      t.text :history
      t.text :organization
      t.string :email
      t.date :founded_at
      t.integer :status
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      t.integer :points

      t.timestamps
    end
    add_index :groups, :category_id
  end
end
