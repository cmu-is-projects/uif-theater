class ItemCategory < ActiveRecord::Base

	# Relationships
	belongs_to :item
	belongs_to :category
	
	# Validations
	validates_numericality_of :item_id, :only_integer => true, :greater_than => 0
	validates_numericality_of :category_id, :only_integer => true, :greater_than => 0

end
