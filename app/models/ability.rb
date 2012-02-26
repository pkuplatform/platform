class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :admin, :backend
      can :admin, :site
    end

    can :like, Profile do |p|
      not UserRelation.where(:liking_id => user.id, :liked_id => p.user.id).exists?
    end

    can :exit, Group do |group|
      group.persons.include?(user) and not group.admin == user
    end

    can :join, Group do |group|
      not group.persons.include?(user) and not group.tenders.include?(user)
    end

    can :like, Group do |group|
      not group.persons.include?(user) and not group.followers.include?(user)
    end

    can :admin, Group do |group|
      not group.nil? and not group.id.nil? and group.admins.include?(user)
    end

    can :exit, Activity do |activity|
      not activity.admin == user and activity.persons.include?(user)
    end

    can :join, Activity do |activity|
      not activity.persons.include?(user) and not activity.tenders.include?(user)
    end

    can :like, Activity do |activity|
      not activity.persons.include?(user) and not activity.followers.include?(user)
    end

    can :admin, Activity do |activity|
      not activity.nil? and not activity.id.nil? and activity.admins.include?(user)
    end

    can :delete, Comment do |comment|
      (user == comment.user) || (can? :manage, comment.commentable) 
    end

    can :edit, Profile do |profile|
      user.id == profile.user.id
    end

    can :admin, Picture do |picture|
      picture&&picture.id&&((can? :admin, picture.imageable)||(picture.user==user))
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
