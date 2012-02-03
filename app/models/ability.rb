class Ability
  include CanCan::Ability

  def initialize(user)

    can :exit, Group do |group|
      group.members.include?(user)
    end

    can :join, Group do |group|
      not group.members.include?(user) and not group.tenders.include?(user)
    end

    can :like, Group do |group|
      not group.followers.include?(user)
    end

    can :admin, Group do |group|
      not group.nil? and not group.id.nil? and group.admins.include?(user)
    end

    can :exit, Activity do |activity|
      activity.members.include?(user)
    end

    can :join, Activity do |activity|
      not activity.members.include?(user) and not activity.tenders.include?(user)
    end

    can :like, Activity do |activity|
      not activity.followers.include?(user)
    end

    can :admin, Activity do |activity|
      not activity.nil? and not activity.id.nil? and activity.admins.include?(user)
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
