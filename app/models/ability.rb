  class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    can :manage, Course do |course|
      user.instructs?(course)
    end

    cannot :create, Course

    can :create, Course if user.can_create_courses == true

    can :read, Course do |course|
      user.enrolled?(course) || user.assists?(course)
    end

    can :manage, Capsule do |capsule|
      capsule.course.edited_by?(user)
    end

    can :manage, Lecture do |lecture|
      lecture.capsule.course.edited_by?(user)
    end

    can :read, Lecture do |lecture|
      lecture.capsule.course.has?(user)
    end

    can :manage, ProblemSet do |problem_set|
      problem_set.capsule.course.edited_by?(user)
    end

    can :manage, Assignment do |assignment|
      assignment.course.edited_by?(user)
    end

    can :manage, Document do |document|
      if document.assignment
        document.assignment.course.edited_by?(user)
      elsif document.submission
        false
      elsif document.grade
        document.grade.assignment.course.edited_by?(user)
      elsif document.course
        document.course.edited_by?(user)
      elsif document.capsule
        document.capsule.course.edited_by?(user)
      else
        document.lecture.capsule.course.edited_by?(user)
      end
    end

    can :manage, Topic do |topic|
      topic.course.has?(user)
    end

  end

end
