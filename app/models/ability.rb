class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, [Profile], user_id: user.id

    can :manage, :all if user.has_role? :admin

    if user.has_role? :trainer
      can :manage, Course, user_id: user.id
      can :manage, Lesson do |lesson|
        lesson.course.user == user
      end
      can :read, :all
    end

    can :read, Course do |course|
      user.participate_in?(course) && !user.banned_in?(course)
    end

    can :read, Lesson do |l|
      user.participate_in?(l.course) && user.banned_in?(l.course)
    end

    can :read, Hometask do |hometask|
      user.participate_in?(hometask.lesson.course) && !user.banned_in?(hometask.lesson.course)
    end
  end
end
