class Organization < ActiveRecord::Base

  # Relationships
  has_many :users
  has_many :notes, :as => :notable, :dependent => :destroy
  
  # Callbacks
  before_save :reformat_phone

  # Validations
  validates_presence_of :name
  # zip code is only 5 digits (no +4 support right now)
  validates_format_of :zip, :with => /^\d{5}$/, :allow_blank => true, :message => "should be five digits long", :allow_blank => true
  # phone can have dashes, spaces, dots and parens, but must be 10 digits
  validates_format_of :phone, :with => /^(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})$/, :allow_blank => true, :message => "should be 10 digits (area code needed) and delimited with dashes only"

  # Scopes
  scope :alphabetical, order('name')
  scope :active, where('active = ?', true)


  # Callback code
  private
  # We need to strip non-digits before saving to db
  def reformat_phone
    phone = self.phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone       # reset self.phone to new string
  end
end
