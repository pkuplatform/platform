class CreateRankLists < ActiveRecord::Migration
  def change
    create_table :rank_lists do |t|
      t.string :name
      t.string :award
      t.integer :identify_id, :unique => true

      t.timestamps
    end
  end
end
