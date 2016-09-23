class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    
    can :manage, :all if user.super_admin

  end
end
