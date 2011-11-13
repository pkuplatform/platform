class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.references :imageable, :polymorphic => true

      t.timestamps
    end
    add_index :albums, [:imageable_id, :imageable_type]
  end
end
