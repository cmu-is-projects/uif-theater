class RequestItem < ActiveRecord::Base
  
  # Relationships
	belongs_to :request
	belongs_to :item
	
	# Validations
	validates_numericality_of :quantity_requested, :only_integer => true, :greater_than => 0
	validates_numericality_of :quantity_approved, :only_integer => true, :greater_than => 0
	validates_numericality_of :request_id, :only_integer => true, :greater_than => 0
	validates_numericality_of :item_id, :only_integer => true, :greater_than => 0
	validates_datetime :date_checked_out
	
end
