module CategoriesHelper
  # Helper method to generate drop-down menu for categories form  
  def category_menu_options
    categories = Category.alphabetical.active.all
    final = Array.new
    
    # find the base categories (ones that have no parents)
    base_categories = categories.map{|c| c if c.subcategory_of.nil?}.compact!
    
    # go through each base category and add the category and its subs to final
    base_categories.each do |b_cat|
      subs = b_cat.subcategories
      final << ["#{b_cat.name}", b_cat.id]
      unless subs.empty?
        subs.sort_by{|sc| sc.name}.each do |s_cat|
          # add the subcategory to the array of options
          final << ["- #{s_cat.name}", s_cat.id]
          # check to see if there are any subcategories of this subcategory
          sub_subcategories = s_cat.subcategories
          # if there are subcategories, add to menu
          unless sub_subcategories.empty?
            sub_subcategories.sort_by{|sc| sc.name}.each do |ss_cat|
              final << ["-- #{ss_cat.name}", ss_cat.id]
            end
          end
        end
      end
    end
    final
  end
  
end
