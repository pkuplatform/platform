class AddColumnsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :banner_file_name, :string
    add_column :activities, :banner_content_type, :string
    add_column :activities, :banner_file_size, :integer
    add_column :activities, :banner_updated_at, :datetime
  end
end
