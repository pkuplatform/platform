class AddColumns < ActiveRecord::Migration
  def change
    add_column :sms, :status, :integer
    add_column :form_second_building_applications, :classroom, :string
  end
end
