class WallMessage < ActiveRecord::Base
  scope :latest_first, order("created_at DESC")
  validates_presence_of :user, :sender, :text
  validates_length_of :text, :maximum => 64
  belongs_to :user
  belongs_to :sender, :class_name => 'User'
end
