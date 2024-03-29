class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :target
      t.boolean :accepted, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
