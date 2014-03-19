class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # if a member, they can manage their own wikis 
    # (or create new ones)
    if user.role? :free
        can :update, Wiki
        cannot :update, Wiki, :public => false 
        can :create, :all 
    end

    # Clients can read their own private wikis
    if user.role? :basic
        can :update, Wiki, :public => false 
        can :read, Wiki, :user_id => user.id, public: false
        can :destroy, Wiki, :user_id => user.id
        can :manage, Wiki, :collaborations => { :user_id => user.id }
        can :view, :basic
    end

    if user.role? :pro
        can :update, Wiki, :public => false 
        can :read, Wiki, :user_id => user.id, public: false
        can :destroy, Wiki, :user_id => user.id
        can :manage, Wiki, :collaborations => { :user_id => user.id }
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

    can :read, Wiki, public: true 
  end
end
