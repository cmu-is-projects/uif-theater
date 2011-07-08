class Color < ActiveRecord::Base
  # Relationships
  has_many :item_colors
  has_many :items, :through => :item_colors
  
  # Validations
  validates_presence_of :name
  
end
