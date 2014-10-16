class Attachment < ActiveRecord::Base
  attr_accessible :idea_id, :image, :remote_image_url

  belongs_to :idea

  mount_uploader :image, ImageUploader

  def blank?
    self.image.to_s.empty?
  end

  def url
    self.image_url
  end
  
end
