class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest, user (not logged in)

    # Detailing what each user is allowed to do. 
    if user.role? :admin 
      can :manage, :all
      
    elsif user.role? :coordinator
      can :read, User
      can :read, Organization
      can :manage, Item
      can :manage, Note
      can :manage, Gender
      can :manage, Location
      can :manage, ItemGender
      can :manage, ItemCategory
      can :manage, Category
      can :manage, Color
      can :manage, Photo
      can :manage, Request
      can :manage, Return
      
    else
      can :read, Note
      can :manage, Item
      cannot :destroy, Item
      # cannot :update, Item
      # can :read, Item
      # can :add, Item
      can :read, Gender
      can :read, ItemGender
      can :read, ItemCategory
      can :read, Category
      can :read, Photo
      can :create, Request
  	  can :update, Request do |request|
  		  requestor.id == user.id
  	  end
  	  can :read, Request do |request|
  		  requestor.id == user.id
  	  end
    end 
  end
end
