class AddColumnsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :announcement, :text
  end
end
