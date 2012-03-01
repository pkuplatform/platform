class AddColumnsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :announcement, :text
  end
end
