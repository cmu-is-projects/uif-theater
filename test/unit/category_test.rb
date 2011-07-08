require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
	# Testing Relationships 
	should have_many :item_categories
	should have_many(:items).through(:item_categories)
	
	# Testing Validations
	should validate_presence_of :name
	should validate_numericality_of(:subcategory_of)
	should allow_value(nil).for(:subcategory_of)
	should_not allow_value(0).for(:subcategory_of)
	should_not allow_value(3.5).for(:subcategory_of)
	should_not allow_value("abcd").for(:subcategory_of)
	should_not allow_value(-87).for(:subcategory_of)
	
end
