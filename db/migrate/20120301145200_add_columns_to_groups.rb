class AddColumnsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :boss_id, :integer
  end
end
