class RemoveDeltaFromProfiles < ActiveRecord::Migration
  def self.up
    remove_column :profiles, :delta
  end

  def self.down
    add_column :profiles, :delta, :boolean, :default => true, :null => false
  end
end
