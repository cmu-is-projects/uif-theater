class HomeController < ApplicationController
  def home
    if user_signed_in?
		  redirect_to items_path if current_user.is_partner?
      @pending_users = User.pending.alphabetical.all
      @pending_requests = Request.pending.chronological.all
    else
      @user = User.new
    end
  end

  def about
  end

  def contact
  end
  
  def policy
  end
  
  def search
    @query=params[:query]
    costumes = Item.search(@query, "costumes")
    props = Item.search(@query, "props")
    staging = Item.search(@query, "staging")
    @costumes = Kaminari.paginate_array(costumes).page(params[:page]).per(21)
    @props = Kaminari.paginate_array(props).page(params[:page]).per(21)
    @staging = Kaminari.paginate_array(staging).page(params[:page]).per(21)
    @total_hits = costumes.size + props.size + staging.size
    @num_per_row = 6
  end

end