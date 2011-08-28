class Profile < ActiveRecord::Base

  belongs_to :user

  attr_accessible :gender, :birth_date, :status, :country, :city, :school, 
  :phone_number, :skype_id, :icq_number, :avatar

  validates_presence_of :user
  validates_uniqueness_of :user_id
  validates_inclusion_of :gender, :in => ["Male", "Female"], :allow_nil => true
  validates_date_of :birth_date, :before => Proc.new { Time.now }, :allow_nil => true
  validates_length_of :country, :city, :school, :phone_number, :skype_id, :maximum => 16,
    :too_long => "%{count} characters is the maximum allowed"
  validates_format_of :icq_number, :with => /^[1-9][0-9]{4,8}$/,
    :message => "Invalid ICQ UIN"
  validates_length_of :status, :maximum => 64,
    :too_long => "%{count} characters is the maximum allowed"

  has_attached_file :avatar, 
    :styles => {
        :original => ["1024x768>", :jpg], 
        :large => ["300x400#", :jpg], 
        :medium => ["150x200#", :jpg], 
        :thumb => ["75x100#", :jpg]
    }, :convert_options => { :all => '-background white -flatten +matte'}, 
    :default_url => "/system/avatars/missing_:style.jpg"

  def update_status(status)
    self.status = status
    if self.save
      self.user.spam_friends_walls_with status
      true
    else
      false
    end
  end

  def age
    birthday = birth_date.to_date
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years #for days before birthday
    age
  end

end