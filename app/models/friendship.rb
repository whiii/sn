class Friendship < ActiveRecord::Base

  scope :unaccepted, where( :accepted => false )

  belongs_to :user
  belongs_to :target, :class_name => 'User'

  validates_presence_of [:user, :target]
  validates_uniqueness_of :target, :scope => :user_id 

  after_destroy :delete_inverse_friendship

  def accept
    unless accepted?
      self.accepted = true;
      self.save
      Friendship.create(:user => self.target, :target => self.user, :accepted => true)
    end
  end

  def accepted?
    self.accepted
  end

  private

    def delete_inverse_friendship
      Friendship.where(:user_id => self.target.id, :target_id => self.user.id).delete_all
    end
    
end
