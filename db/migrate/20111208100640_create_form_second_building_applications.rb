class CreateFormSecondBuildingApplications < ActiveRecord::Migration
  def change
    create_table :form_second_building_applications do |t|
      t.string :zhubanren
      t.string :fuzeren
      t.integer :status
      t.references :group

      t.timestamps
    end
  end
end
