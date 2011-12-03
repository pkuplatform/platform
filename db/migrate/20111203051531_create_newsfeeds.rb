class CreateNewsfeeds < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.references :user
      t.references :event
      t.integer :times, :default => 0

      t.timestamps
    end
    add_index :newsfeeds, :user_id
    add_index :newsfeeds, :event_id
  end
end
