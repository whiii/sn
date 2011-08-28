class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, :dependent => :destroy

  validates_presence_of :name, :user
  validates_length_of :name, :maximum => 16,
    :too_long => "%{count} characters is the maximum allowed"
  validates_uniqueness_of :name, :scope => :user_id
end
