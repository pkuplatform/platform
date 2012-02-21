class AddColumnToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :pyname, :string
  end
end
