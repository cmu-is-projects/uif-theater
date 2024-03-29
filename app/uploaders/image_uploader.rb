# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # # Include RMagick support:
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # To make compatible with heroku
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Process files as they are uploaded:
  process :resize_to_limit => [200, 200]
  
  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_limit => [80, 80]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
