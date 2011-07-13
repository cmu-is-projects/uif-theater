class HomeController < ApplicationController
  def home
    if user_signed_in?
		  redirect_to items_path if current_user.is_partner?
      @pending_users = User.pending.alphabetical.all
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
    @c = Item.search(@query, "costumes")
    @p = Item.search(@query, "props")
    @s = Item.search(@query, "staging")
    @costumes = Kaminari.paginate_array(@c).page(params[:page]).per(21)
    @props = Kaminari.paginate_array(@p).page(params[:page]).per(21)
    @staging = Kaminari.paginate_array(@s).page(params[:page]).per(21)
    @total_hits = @c.size + @p.size + @s.size
    @num_per_row = 6
  end

end