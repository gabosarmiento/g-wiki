class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # if a member, they can manage their own wikis 
    # (or create new ones)
    if user.role? :member
        can :update, :all
        can :create, :all
    end

    # Moderators can delete any wiki
    if user.role? :moderator
      can :destroy, Wiki
    end

    # Clients can create private wikis
    if user.role? :client
        can :read, Wiki 
    end
    
    # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end

    can :read, public: true 
  end
end
