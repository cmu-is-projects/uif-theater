class Location < ActiveRecord::Base
  
  # Relationships
  has_many :items
  
  # List of storage types
  STORAGE_TYPES = [['Floor', 'floor'],['Rack', 'rack'],['Shelf', 'shelf']]
  
  # Validations
  validates_numericality_of :container, :greater_than => 0, :only_integer => true, :allow_blank => true
  validates_presence_of :storage_unit
  validates_presence_of :storage_type
  validates_inclusion_of :storage_type, :in => %w[rack shelf floor], :message => "is not recognized by the system" 
  validates_format_of :storage_unit, :with => /^[A-Z]+$/, :message => "is invalid - use capital letters only"
  validates_format_of :container, :with => /^[\d]+$/, :message => "is invalid - use numbers only", :allow_blank => true
  
  # Scopes
  scope :alphabetical, order('storage_type, storage_unit, container')
  
  # Other methods
  def name
    "#{storage_type.capitalize} #{storage_unit}#{container}"
  end
  
end
