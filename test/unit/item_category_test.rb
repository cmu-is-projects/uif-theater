require 'test_helper'

class ItemCategoryTest < ActiveSupport::TestCase
	# Testing Relationships 
	should belong_to :item
	should belong_to :category
	
	# Testing Validations
	should validate_numericality_of(:item_id)
	should_not allow_value(0).for(:item_id)
	should_not allow_value(3.5).for(:item_id)
	should_not allow_value("abcd").for(:item_id)
	should_not allow_value(-87).for(:item_id)
	
	should validate_numericality_of(:category_id)
	should_not allow_value(0).for(:category_id)
	should_not allow_value(3.5).for(:category_id)
	should_not allow_value("abcd").for(:category_id)
	should_not allow_value(-87).for(:category_id)
end
