class AddColumnToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :pyname, :string
  end
end
