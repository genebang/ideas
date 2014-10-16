# encoding: utf-8
require 'carrierwave'

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type
  storage :fog

  def store_dir
    "ideas/idea_#{model.idea_id}"
  end

  version :thumb do
    process :resize_to_limit => [200, 200]
  end

  # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # storage :file
end
