class Photo < ActiveRecord::Base
  # Relationships
  belongs_to :item
  
  # Connect to uploader
  mount_uploader :image, ImageUploader
  
end
