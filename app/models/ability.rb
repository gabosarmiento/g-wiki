class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # if a member, they can manage their own wikis 
    # (or create new ones)
    if user.role? :member
        can :update, Wiki
        cannot :update, Wiki, :public => false 
        can :create, :all
    end

    # Moderators can delete any wiki
    if user.role? :moderator
      can :destroy, Wiki
    end

    # Clients can read their own private wikis
    if user.role? :client
        can :update, Wiki, :public => false 
        can :read, Wiki, :user_id => user.id, public: false
    end
    
    # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end

    can :read, Wiki, public: true 
  end
end
