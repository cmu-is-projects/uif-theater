class ItemsController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource

  def index   
    # session[:subcategory_id] = params[:id]
    props_cat = (params[:id].nil? ? "Props" : "#{Category.find(params[:id]).name}")
    costumes_cat = (params[:id].nil? ? "Costumes" : "#{Category.find(params[:id]).name}")
    staging_cat = (params[:id].nil? ? "Staging" : "#{Category.find(params[:id]).name}")
    
    # props_cat = (session[:subcategory_id].nil? ? "Props" : "#{Category.find(session[:subcategory_id]).name}")
    # costumes_cat = (session[:subcategory_id].nil? ? "Costumes" : "#{Category.find(session[:subcategory_id]).name}")
    # staging_cat = (session[:subcategory_id].nil? ? "Staging" : "#{Category.find(session[:subcategory_id]).name}")
    # session[:subcategory_id] = nil
    
    @num_per_row = 4
    
    @subcat_costumes = Category.all_names_associated_with "Costumes"
    @subcat_props = Category.all_names_associated_with "Props"
    @subcat_staging = Category.all_names_associated_with "Staging"
    
    @props = Kaminari.paginate_array(Item.just_for(props_cat)).page(params[:page]).per(16)
    @costumes = Kaminari.paginate_array(Item.just_for(costumes_cat)).page(params[:page]).per(16)
    @staging = Kaminari.paginate_array(Item.just_for(staging_cat)).page(params[:page]).per(16)
    
    respond_to do |format|
      format.html
      format.js  
    end
  end


  def show
    @item = Item.find(params[:id])
    @notes = @item.notes
    @notable = @item
    @photos = @item.photos
  end


  def new
    @item = Item.new
    photo = @item.photos.build
  end


  def edit
    @item = Item.find(params[:id])
    @photos = @item.photos
  end


  def create
    @item = Item.new(params[:item])

    if @item.save
      redirect_to(@item, :notice => "#{@item.name.capitalize} was added to the system.") 
    else
      render :action => "new" 
    end
  end


  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      redirect_to(@item, :notice => "#{@item.name.capitalize} was updated in the system.") 
    else
      render :action => "edit" 
    end
  end


  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to(items_url)
  end
  
  def add_list_item
    session[:item_ids] = Array.new if session[:item_ids].nil?
    session[:item_ids] << params[:id]
    redirect_to item_path(params[:id])
  end
  
  def remove_from_list
    item_to_remove = params[:id]
    session[:item_ids].delete_at(session[:item_ids].index(item_to_remove))
    redirect_to(items_path, :notice => "Item was removed from your list.")
  end
  
  def browse_subcategories
    session[:subcategory_id] = params[:id]
    redirect_to items_path
    # props = (params[:id].nil? ? "Props" : "#{Category.find(params[:id]).name}")
    # costumes = (params[:id].nil? ? "Costumes" : "#{Category.find(params[:id]).name}")
    # staging = (params[:id].nil? ? "Staging" : "#{Category.find(params[:id]).name}")
    # 
    # @num_per_row = 4
    # 
    # @subcat_costumes = Category.all_names_associated_with "Costumes"
    # @subcat_props = Category.all_names_associated_with "Props"
    # @subcat_staging = Category.all_names_associated_with "Staging"
    # 
    # @props = Kaminari.paginate_array(Item.just_for(props)).page(params[:page]).per(16)
    # @costumes = Kaminari.paginate_array(Item.just_for(costumes)).page(params[:page]).per(16)
    # @staging = Kaminari.paginate_array(Item.just_for(staging)).page(params[:page]).per(16)
  end
end
