class Photo < ActiveRecord::Base

  belongs_to :album

  attr_accessible :image, :comment, :created_at

  validates_presence_of :album, :image
  validates_length_of :comment, :maximum => 64,
    :too_long => "%{count} characters is the maximum allowed"

  has_attached_file :image, 
    :styles => {
        :original => ["1600x1200>", :jpg], 
        :for_gallery => ["640x480>", :jpg], 
        :thumb => ["80x60#", :jpg]
    }, :convert_options => { :all => '-background white -flatten +matte'}

end