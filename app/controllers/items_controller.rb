class ItemsController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource

  def index
    # @items = Item.all
    @p = Item.just_for("Props").alphabetical.page(params[:page]).per(21)
    @c = Item.just_for("Costumes").alphabetical.page(params[:page]).per(21)
    @s = Item.just_for("Staging").alphabetical.page(params[:page]).per(21)
    
    @props = Kaminari.paginate_array(@p).page(params[:page]).per(21)
    @costumes = Kaminari.paginate_array(@c).page(params[:page]).per(21)
    @staging = Kaminari.paginate_array(@s).page(params[:page]).per(21)
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
    
  end
end
