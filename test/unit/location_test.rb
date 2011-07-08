require 'test_helper'

class LocationTest < ActiveSupport::TestCase
	# Test Relationships
	should have_many :items
	
	# Test validations
	
	should validate_presence_of :storage_unit
	should validate_presence_of :storage_type
	
	should validate_numericality_of(:container)
	should allow_value(nil).for(:container)
	should_not allow_value(0).for(:container)
	should_not allow_value(3.5).for(:container)
	should_not allow_value("abcd").for(:container)
	should_not allow_value(-87).for(:container)
	
	should allow_value("rack").for(:storage_type)
	should allow_value("shelf").for(:storage_type)
	should allow_value("floor").for(:storage_type)
	should_not allow_value("bad").for(:storage_type)
	should_not allow_value(1).for(:storage_type)
	
end
