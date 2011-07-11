class HomeController < ApplicationController
  def home
    if user_signed_in?
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
    @costumes = Item.search(@query, "costumes").page(params[:page]).per(21)
    @props = Item.search(@query, "props").page(params[:page]).per(21)
    @staging = Item.search(@query, "staging").page(params[:page]).per(21)
    @total_hits = @costumes.size + @props.size + @staging.size
  end

end
