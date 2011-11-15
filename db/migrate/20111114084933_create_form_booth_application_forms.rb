class CreateFormBoothApplicationForms < ActiveRecord::Migration
  def change
    create_table :form_booth_application_forms do |t|
      t.string :app_name
      t.integer :app_gender
      t.string :app_title
      t.string :app_email
      t.string :app_phone
      t.string :app_institution
      t.string :person_in_charge
      t.date :start_at
      t.date :end_at
      t.integer :booth_count
      t.string :app_reason
      t.string :display_form
      t.boolean :app_confirm
      t.date :app_confirm_date
      t.string :boss_advice
      t.boolean :boss_confirm
      t.date :boss_confirm_date
      t.string :sd_advice
      t.boolean :sd_confirm
      t.date :sd_confirm_date
      t.string :remark

      t.timestamps
    end
  end
end
