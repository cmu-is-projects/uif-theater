require 'test_helper'

class ItemTest < ActiveSupport::TestCase
	# Testing Relationships
	should have_many :item_categories
	should have_many(:categories).through(:item_categories)
	should have_many :photos
	should have_many :item_genders
	should have_many(:genders).through(:item_genders)
	should belong_to :location
	
	# Testing Validation
	should validate_presence_of :name
	should validate_presence_of :status
	
	should validate_numericality_of(:quantity)
	should allow_value(0).for(:quantity)
	should_not allow_value(3.5).for(:quantity)
	should_not allow_value("abcd").for(:quantity)
	should_not allow_value(-87).for(:quantity)
	
	should validate_numericality_of(:location_id)
	should allow_value(nil).for(:location_id)
	should_not allow_value(0).for(:location_id)
	should_not allow_value(3.5).for(:location_id)
	should_not allow_value("abcd").for(:location_id)
	should_not allow_value(-87).for(:location_id)
end
