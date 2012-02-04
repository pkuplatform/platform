class AddDeltaForSphinx < ActiveRecord::Migration
  def change
    add_column :groups, :delta, :boolean, :default => true, :null => false
    add_column :activities, :delta, :boolean, :default => true, :null => false
    add_column :profiles, :delta, :boolean, :default => true, :null => false
  end
end
