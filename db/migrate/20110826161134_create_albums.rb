class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.belongs_to :user
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
