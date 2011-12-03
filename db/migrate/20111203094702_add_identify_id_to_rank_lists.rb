class AddIdentifyIdToRankLists < ActiveRecord::Migration
  def change
    add_column :rank_lists, :identify_id, :integer, :unique => true
  end
end
