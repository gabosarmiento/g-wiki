class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :free
        can :read, Wiki, :public => false, :user_id => user.id
        can :read, Wiki, :public => false, :collaborations => {:user_id => user.id}
        can :create, Wiki 
        can :destroy, Wiki, :user_id => user.id
        can :update, Wiki, :public => true 
        can :update, Wiki, :public => false, :user_id => user.id
        can :manage, User, :user_id => user.id 
        # cannot :manage, Collaboration
    end

    if user.role? :basic
        can :read, Collaboration, :user_id => user.id
        can :create, Collaboration, :collaborations => { :user_id => user.id } 
        can :destroy, Collaboration, :collaborations => { :user_id => user.id } 
        can :manage, Wiki, :collaborations => { :user_id => user.id } 
        can :view, :basic
    end

    if user.role? :pro
        can :view, :pro
    end
    
    can :read, Wiki, :public => true
  end
end
