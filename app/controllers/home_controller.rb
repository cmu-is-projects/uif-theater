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
    @costumes = Item.search(@query, "costumes")
    @props = Item.search(@query, "props")
    @staging = Item.search(@query, "staging")
    @total_hits = @costumes.size + @props.size + @staging.size
  end

end
