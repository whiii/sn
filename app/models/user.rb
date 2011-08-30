class User < ActiveRecord::Base

  scope :nine_first, limit(9)

  has_one :profile, :dependent => :destroy

  has_many :accepted_friendships, :class_name => 'Friendship', :foreign_key => :user_id, 
    :conditions => { :accepted => true }, :dependent => :destroy
  has_many :unaccepted_inversed_friendships, :class_name => 'Friendship', 
    :foreign_key => :target_id, :conditions => { :accepted => false }, :dependent => :destroy

  has_many :friends, :through => :accepted_friendships, :source => :target
  has_many :potential_friends, :through => :unaccepted_inversed_friendships, 
    :source => :user

  has_many :wall_messages, :dependent => :destroy
  has_many :sent_wall_messages, :class_name => 'WallMessage', 
    :foreign_key => :sender_id, :dependent => :destroy

  has_many :albums

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation, :remember_me,
                  :confirmation_token, :confirmed_at, :confirmation_sent_at, :is_admin

  validates_presence_of :firstname, :lastname
  validates_length_of :firstname, :lastname, :maximum => 16,
    :too_long => "%{count} characters is the maximum allowed"
  

  after_create :build_profile

  def admin?
    self.is_admin    
  end

  def spam_friends_walls_with (message)
    self.friends.each {|f| WallMessage.create :user => f, :sender => self, 
      :text => message}
  end

  def self.get_daily_stats (from, to)
    (from .. to).inject({}) do |result, day|
      result[day.strftime("%d/%m/%Y")] = User.where(:created_at => day.beginning_of_day..day.end_of_day).count
      result
    end
  end
  
end
