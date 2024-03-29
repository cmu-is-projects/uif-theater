class Category < ActiveRecord::Base

	#Relationships
	has_many :item_categories
	has_many :items, :through => :item_categories
	
	# Validations
	validates_presence_of :name
	validates_numericality_of :subcategory_of, :only_integer => true, :greater_than => 0, :allow_blank => true

  # Scopes
  # by default, list categories in alphabetical order by name
  scope :alphabetical, order('name')
  scope :active, where('active = ?', true)
  
  # Other methods
  def parent_category
    subcategory_of.nil? ? "--" : Category.find(subcategory_of).name
  end
  
  def subcategories
    Category.all.map{|c| c if c.subcategory_of == self.id}.compact!
  end

  def self.all_ids_associated_with(parent_category)
    sub_ids = Array.new
    p_cat = Category.find_by_name(parent_category)
    unless p_cat.nil?
      sub_ids << p_cat.id
      subcats = p_cat.subcategories.map{|s| s}
      unless subcats.empty? || subcats.nil?
        subcats.each do |s_cat|
          sub_ids << s_cat.id
          s_cat.subcategories.each{|sc| sub_ids << sc.id}
        end
      end
    end
    sub_ids
  end
  
  def self.all_names_associated_with(parent_category)
    sub_ids = Hash.new
    p_cat = Category.find_by_name(parent_category)
    unless p_cat.nil?
      sub_ids[p_cat.id] = p_cat.name
      subcats = p_cat.subcategories.map{|s| s}
      unless subcats.empty? || subcats.nil?
        subcats.each do |s_cat|
          sub_ids[s_cat.id] = s_cat.name
          # s_cat.subcategories.each{|sc| sub_ids[sc.id] = sc.name}
        end
      end
    end
    sub_ids
  end
  
  def all_ids_associated_with
    sub_ids = Array.new
    sub_ids << self.id
    subcats = self.subcategories.map{|s| s}
    unless subcats.empty? || subcats.nil?
      subcats.each do |s_cat|
        sub_ids << s_cat.id
        s_cat.subcategories.each{|sc| sub_ids << sc.id}
      end
    end
    sub_ids.compact!
  end

end
