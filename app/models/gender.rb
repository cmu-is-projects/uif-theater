class Gender < ActiveRecord::Base
  
  # Relationships
  has_many :item_genders
  has_many :items, :through => :item_genders
  
  # Validations
  validates_presence_of :name
  
  # Scopes
  # by default, list genders in alphabetical order by name
  scope :all, order('name')
  
end
