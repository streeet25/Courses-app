class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Lesson do |lesson|
      user.subscribed_to?(lesson.course) && banned_in?(lesson.course)
    end
    
    can :manage, [Profile, Hometask], user_id: user.id

    if user.has_role? :admin
      can :manage, :all
    end  

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

    can :read, Lesson do |lesson|
      user.participate_in?(lesson.course) && !user.banned_in?(lesson.course)
    end
  end
end
