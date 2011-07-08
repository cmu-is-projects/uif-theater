class ItemGender < ActiveRecord::Base
  
  # Relationships
  belongs_to :item
  belongs_to :gender

  # Validations
  validates_numericality_of :item_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :gender_id, :greater_than => 0, :only_integer => true
  
end
