class AddDeltaColumnsToUserAndProfile < ActiveRecord::Migration
  def self.up
    add_column :users, :delta, :boolean, :default => true, :null => false
    add_column :profiles, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :users, :delta
    remove_column :profiles, :delta
  end
end
