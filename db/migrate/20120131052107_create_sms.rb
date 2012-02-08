class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.references :group
      t.text :content
      t.integer :status, :default => -1

      t.timestamps
    end
    add_index :sms, :group_id
  end
end
