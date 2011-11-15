class CreateFormSecondBuildingApplicationForms < ActiveRecord::Migration
  def change
    create_table :form_second_building_application_forms do |t|
      t.string :organizer
      t.string :person_in_charge
      t.string :contacter_name
      t.string :contacter_school
      t.string :contact_way
      t.string :speaker
      t.string :institution
      t.string :speaker_title
      t.string :speech_title
      t.string :video_content
      t.string :other_type
      t.datetime :start_at
      t.datetime :end_at
      t.integer :attend_count
      t.string :boss_reply
      t.string :provost_reply
      t.string :remark

      t.timestamps
    end
  end
end
