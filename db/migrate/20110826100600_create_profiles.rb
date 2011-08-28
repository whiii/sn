class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|

      t.references :user

      t.string :gender
      t.date :birth_date

      t.string :country
      t.string :city
      t.string :school

      t.string :phone_number
      t.string :skype_id
      t.string :icq_number

      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.string :status, :default => ""

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
