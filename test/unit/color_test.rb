require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:item_colors)
  should have_many(:items).through(:item_colors)
  
  # Test validations
  should validate_presence_of(:name)
end

