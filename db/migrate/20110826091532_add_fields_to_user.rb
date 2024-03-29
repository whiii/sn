class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :is_admin, :boolean, :default => false
  end

  def self.down
    remove_column :users, :is_admin
    remove_column :users, :firstname
    remove_column :users, :lastname
  end
end
