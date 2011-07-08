require 'test_helper'

class ItemGenderTest < ActiveSupport::TestCase
  # Testing Relationships 
	should belong_to :item
	should belong_to :gender
	
	# Testing Validations
	should validate_numericality_of(:item_id)
	should_not allow_value(0).for(:item_id)
	should_not allow_value(3.5).for(:item_id)
	should_not allow_value("abcd").for(:item_id)
	should_not allow_value(-87).for(:item_id)
	
	should validate_numericality_of(:gender_id)
	should_not allow_value(0).for(:gender_id)
	should_not allow_value(3.5).for(:gender_id)
	should_not allow_value("abcd").for(:gender_id)
	should_not allow_value(-87).for(:gender_id)
end
