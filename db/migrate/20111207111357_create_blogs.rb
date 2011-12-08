class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.references :author
      t.references :activity

      t.timestamps
    end
    
    add_index :blogs, [:activity_id, :author_id]

  end
end
