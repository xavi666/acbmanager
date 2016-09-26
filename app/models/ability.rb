class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    case controller_namespace
      when 'Admin'
        can :manage, :all if user and user.super_admin
      else
        can :read, :all
        # rules for non-admin controllers here
    end
  end

end
