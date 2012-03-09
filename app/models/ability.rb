class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :admin, :backend
      can :admin, :site
    end

    can :admin, User do |u|
      u==user
    end

    can :like, Profile do |p|
      not p.user.fans.include?(user)
    end

    can :like, User do |u|
      not u.fans.include?(user)
    end

    can :exit, Group do |group|
      group.members.include?(user) and not group.boss == user
    end

    can :join, Group do |group|
      not group.members.include?(user) and not group.applicants.include?(user)
    end

    can :like, Group do |group|
      not group.members.include?(user) and not group.fans.include?(user)
    end

    can :unlike, Group do |group|
      group.fans.include?(user)
    end

    can :admin, Group do |group|
      user.admin? or (not group.nil? and not group.id.nil? and group.admins.include?(user))
    end

    can :exit, Activity do |activity|
      not activity.boss == user and activity.members.include?(user)
    end

    can :join, Activity do |activity|
      not activity.members.include?(user) and not activity.applicants.include?(user)
    end

    can :like, Activity do |activity|
      not activity.members.include?(user) and not activity.fans.include?(user)
    end

    can :unlike, Activity do |activity|
      activity.fans.include?(user)
    end

    can :admin, Activity do |activity|
      not activity.nil? and not activity.id.nil? and (activity.admins.include?(user) or (user.can? :admin, activity.group))
    end

    can :delete, Comment do |comment|
      (user == comment.user) || (can? :admin, comment.commentable) 
    end

    can :edit, Profile do |profile|
      user.id == profile.user.id || (can? :admin, :site)
    end

    can :admin, Picture do |picture|
      picture&&picture.id&&((can? :admin, picture.imageable)||(picture.user==user))
    end

    can :read, Circle do |circle|
      (user.can? :admin, circle.owner) || (circle.public)
    end

    can :write, Circle do |circle|
      ((circle.status&Constant::Special == 0) && (user.can? :admin, circle.owner))||
      ((circle.status == Constant::Admin) && (circle.owner.boss==user||user.can?(:admin, :site)))||
      ((circle.status == Constant::Member) && (user.can? :admin, circle.owner)) ||
      (user.can? :admin, :site)
    end

    can :select, Circle do |circle|
      ((circle.status&Constant::Special == 0) && (user.can? :admin, circle.owner))||
      ((circle.status == Constant::Admin) && (circle.owner.boss==user||user.can?(:admin, :site)))
    end

    can :delete, Circle do |circle|
      (circle.status&Constant::Special == 0) && (user.can? :admin, circle.owner)
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
