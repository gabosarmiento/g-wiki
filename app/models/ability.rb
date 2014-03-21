class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # if a member they can manage their own wikis or create new ones
    if user.role? :free
        can :read, Wiki, {:user_id => user.id, :public => false}
        can :create, Wiki 
        can :destroy, Wiki, :user_id => user.id
        can :update, Wiki
        cannot :update, Wiki, :public => false 
        cannot :create, Collaboration 
        cannot :read, Collaboration
        cannot :destroy, Collaboration 
    end

    # Clients can read their own private wikis
    if user.role? :basic
        can :manage, Collaboration 
        can :view, :basic
    end

    if user.role? :pro
        can :view, :pro
    end

    # Moderators can delete any wiki
    if user.role? :moderator
      can :destroy, Wiki
    end
    
    # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end

    can :read, Wiki, :public => true
  end
end
