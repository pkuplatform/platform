class AddColumnsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :boss_id, :integer
  end
end
