class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
      can :manage, Course if user.has_role?(:trainer, Course, user_id: user.id)
      can :read, :all
    end
  end
end
