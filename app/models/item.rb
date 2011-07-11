class Item < ActiveRecord::Base

	# Relationships
	has_many :item_categories
	has_many :categories, :through => :item_categories
	has_many :photos
	has_many :item_genders
	has_many :genders, :through => :item_genders
	has_many :item_colors
	has_many :colors, :through => :item_colors
	belongs_to :location
	has_many :notes, :as => :notable, :dependent => :destroy
	
	# Allow photos to be nested within item
  accepts_nested_attributes_for :photos, :reject_if => lambda { |photo| photo[:image].blank? }, :allow_destroy => true
  
  # Code for category & color tokens
	attr_reader :category_tokens  
  def category_tokens=(ids)  
    self.category_ids = ids.split(",")  
  end
  
  attr_reader :color_tokens  
  def color_tokens=(ids)  
    self.color_ids = ids.split(",")  
  end
  
  # List of item statuses
  ITEM_STATUS = [['Available', 'available'],['In use', 'in_use'],['Missing', 'missing'],['Unavailable', 'unavailable']]
  
	# Validations
	validates_presence_of :name
  # validates_presence_of :color
	validates_presence_of :keywords
	validates_presence_of :status
	validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 0 
	validates_numericality_of :location_id, :only_integer => true, :greater_than => 0, :allow_blank => true
	validates_inclusion_of :status, :in => %w[available in_use missing unavailable], :message => "is not recognized by the system"
	
	def self.build_all_query(str, field)
    query = str.gsub(/[,;:&]/,"").split.join("%' AND \"items\".\"#{field}\" ILIKE '%")
  end
  def self.build_any_query(str, field)
    query = str.gsub(/[,;:&]/,"").split.join("%' OR \"items\".\"#{field}\" ILIKE '%")
  end
	
	# Scopes
	scope :alphabetical, order('name')
  scope :just_props, joins(:categories).where("categories.id IN (#{Category.all_ids_associated_with("Props").join(",")})") #.group(:item_id)
  scope :just_costumes, joins(:categories).where("categories.id IN (#{Category.all_ids_associated_with("Costumes").join(",")})") #.group(:item_id)
  scope :just_staging, joins(:categories).where("categories.id IN (#{Category.all_ids_associated_with("Staging").join(",")})") #.group(:item_id)
  
  scope :search_all_name, lambda { |q| where("\"items\".\"name\" ILIKE '%#{Item.build_all_query(q,'name')}%'") }
  scope :search_any_name, lambda { |q| where("\"items\".\"name\" ILIKE '%#{Item.build_any_query(q,'name')}%'") }
     
  scope :search_all_colors, lambda { |q| joins(:colors).where("colors.name ILIKE '%#{Item.build_all_query(q,'name')}%'") }
  scope :search_all_categories, lambda { |q| joins(:categories).where("categories.name ILIKE '%#{Item.build_all_query(q,'name')}%'") }
  scope :search_all_keywords, lambda { |q| where("items.keywords ILIKE '%#{Item.build_all_query(q,'keywords')}%'") }
  scope :search_all_description, lambda { |q| where("items.description ILIKE '%#{Item.build_all_query(q,'description')}%'") }
  
  scope :search_any_colors, lambda { |q| joins(:colors).where("colors.name ILIKE '%#{Item.build_any_query(q,'name')}%'") }
  scope :search_any_categories, lambda { |q| joins(:categories).where("categories.name ILIKE '%#{Item.build_any_query(q,'name')}%'") }
  scope :search_any_keywords, lambda { |q| where("items.keywords ILIKE '%#{Item.build_any_query(q,'keywords')}%'") }
  scope :search_any_description, lambda { |q| where("items.description ILIKE '%#{Item.build_any_query(q,'description')}%'") }

  def self.search(query, category)
    results = Array.new
    got_it = Array.new
    fields = %w[name keywords colors categories description]
    # fields = %w[name]
    fields.each do |f|
      eval %Q{
        r_all = Item.search_all_#{f}(query).just_#{category}
        r_all.each do |r|
          unless got_it.include?(r.id)
            results << r
            got_it << r.id
          end
        end
        r_any = Item.search_any_#{f}(query).just_#{category}
        r_any.each do |r|
          unless got_it.include?(r.id)
            results << r
            got_it << r.id
          end
        end
      }
    end
    results
  end
  
  def categories_list
    self.categories.map{|c| c.name}.join(", ")
  end
  
  def is_a_prop?
    results = Array.new
    self.categories.map{|c| results << c if c.name == "Props" || c.subcategory_of}
  end
    
end
