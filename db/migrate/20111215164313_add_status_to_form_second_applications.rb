class AddStatusToFormSecondApplications < ActiveRecord::Migration
  def change
    add_column :form_second_building_applications, :status, :integer
  end
end
