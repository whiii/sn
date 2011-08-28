class CreateWallMessages < ActiveRecord::Migration
  def self.up
    create_table :wall_messages do |t|
      t.integer :user_id
      t.integer :sender_id
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :wall_messages
  end
end
