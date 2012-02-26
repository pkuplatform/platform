class CreateDialogs < ActiveRecord::Migration
  def change
    create_table :dialogs do |t|
      t.references :channel
      t.references :user
      t.text :body

      t.timestamps
    end
    add_index :dialogs, :channel_id
    add_index :dialogs, :user_id
  end
end
