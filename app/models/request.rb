class Request < ActiveRecord::Base
  # Relationships 
	has_many :request_items
	has_many :items, :through => :request_items
	belongs_to :requestor, :class_name => "User", :foreign_key => "requestor_id"
	belongs_to :approver, :class_name => "User", :foreign_key => "approver_id"
		
	# Validations
	validates_presence_of :production, :status
	validates_numericality_of :requestor_id, :only_integer => true, :greater_than => 0
	validates_numericality_of :approver_id, :only_integer => true, :greater_than => 0, :allow_blank => true
  validates_datetime :date_processed, :allow_blank => true #,  :on_or_after => :date_of_request
	validates_datetime :date_needed_by #, :on_or_after => :date_of_request
	# validates_datetime :date_of_request 
	
	# List of statuses
	STATUS_LIST = [['Approved', 'approved'], ['Pending', 'pending'], ['Rejected', 'rejected']]
  
  # Scopes
  scope :approved, where('status = ?', 'approved')
  scope :pending, where('status = ?', 'pending')
  scope :rejected, where('status = ?', 'rejected')
  scope :not_pending, where('status != ?', 'pending')
  scope :chronological, order('created_at DESC')
  scope :for_requestor, lambda {|requestor_id| where('requestor_id = ?', requestor_id) }
  
  
  # Other methods
  def current_status
    status.capitalize
  end
	
end
