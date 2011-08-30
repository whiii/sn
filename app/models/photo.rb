class Photo < ActiveRecord::Base

  belongs_to :album

  attr_accessible :image, :comment, :created_at

  validates_presence_of :album
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_length_of :comment, :maximum => 64

  has_attached_file :image, 
    :styles => {
        :original => ["1600x1200>", :jpg], 
        :for_gallery => ["640x480>", :jpg], 
        :thumb => ["80x60#", :jpg]
    }, :convert_options => { :all => '-background white -flatten +matte'}

end