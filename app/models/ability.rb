class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :free
        can :read, Wiki, :public => false, :user_id => user.id
        can :read, Wiki,  Wiki.hidden_to(user) do |wiki|
            wiki.is_collaborator?(user)
        end
        can :create, Wiki 
        can :destroy, Wiki, :user_id => user.id
        can :update, Wiki, :public => true 
        can :update, Wiki, :public => false, :user_id => user.id
        can :update, Wiki, Wiki.hidden_to(user) do |wiki|
            wiki.is_collaborator?(user)
        end
        can :manage, User, :user_id => user.id 
        cannot :manage, Collaboration
    end

    if user.role? :basic
        # can :create, Collaboration, Collaboration.something(collaboration) do |a|
        #     a.is_mine?(user)
        # end
        can :read, Collaboration, :collaborations => { :user_id => user.id } 
        can :view, :basic
    end

    if user.role? :pro
        can :view, :pro
    end
    # Admins can do anything
    if user.role? :admin
      can :manage, :all
    end
    can :read, Wiki, :public => true
  end
end
