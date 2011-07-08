require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  # Testing relationships
  should belong_to(:organization)
  
  # Testing validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  
  should validate_numericality_of(:organization_id)
  should allow_value(nil).for(:organization_id)
	should_not allow_value(0).for(:organization_id)
	should_not allow_value(3.5).for(:organization_id)
	should_not allow_value("abcd").for(:organization_id)
	should_not allow_value(-87).for(:organization_id)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

  should allow_value("admin").for(:role)
	should allow_value("coordinator").for(:role)
	should allow_value("partner").for(:role)
	should_not allow_value("bad").for(:role)
	should_not allow_value(1).for(:role)
	
	should allow_value(1).for(:status)
	should allow_value(0).for(:status)
	should allow_value(-1).for(:status)
	should_not allow_value(2).for(:status)
	should_not allow_value(3.14159).for(:status)
  
end
