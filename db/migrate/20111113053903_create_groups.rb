class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :category
      t.string   :name
      t.string   :pyname
      t.string   :slogan, :default => ""
      t.text     :introduction, :default => ""
      t.text     :description, :default => ""
      t.text     :history, :default => ""
      t.text     :organization, :default => ""
      t.string   :email, :default => ""
      t.date     :founded_at
      t.integer  :status, :default => Constant::Approving
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.integer  :points, :default => 0
      t.boolean  :delta, :default => true, :null => false
      t.text     :announcement
      t.integer  :boss_id

      t.timestamps
    end
    add_index :groups, :category_id
  end
end
