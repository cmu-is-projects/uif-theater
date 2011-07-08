class Note < ActiveRecord::Base
  # Set up notes as polymorphic
  belongs_to :notable, :polymorphic => true
  belongs_to :user
  validates_numericality_of :user_id, :only_integer => true, :greater_than => 0
  
end
