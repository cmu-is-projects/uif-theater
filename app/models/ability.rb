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
      
    else
      can :read, Note
      can :read, Item
      can :read, Gender
      can :read, ItemGender
      can :read, ItemCategory
      can :read, Category
      can :read, Photo
    end 
  end
end
