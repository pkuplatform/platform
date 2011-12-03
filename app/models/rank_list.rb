class RankList < ActiveRecord::Base
  validates :identify_id, :uniqueness => true

  def self.get_rank
    get_most_member_group #1
    get_most_activity_group #2
    get_most_group_user #3
    get_most_activities_user #4
    get_most_liked_user #5
    get_most_followed_group #6
    get_most_members_activity #7
    get_most_subscribers_activity #8
    get_most_subscribers_group #9
  end

private
  #identify_id 1
  def self.get_most_member_group
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      num = group.members.count
      if num > max then
        max = num
        max_group = group
      end
    end

    group = self.find_by_identify_id(1)
    if not group then
      self.create!(:name => 'no group', :award => 'most members group', :identify_id => 1)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most members group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most members group')
    end
  end

  #identify_id 2
  def self.get_most_activity_group
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      num = group.activities.count
      if num > max then
        max = num
        max_group = group
      end
    end

    group = self.find_by_identify_id(2)
    if not group then
      self.create!(:name => 'no group', :award => 'most activities group', :identify_id => 2)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most activities group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most activities group')
    end
  end
  
  #identify_id 3
  def self.get_most_group_user
    max = -1
    max_user = User.first
    User.all.each do |user|
      num = user.groups.count
      if num > max then
        max = num
        max_user = user 
      end
    end

    user = self.find_by_identify_id(3)
    if not user then
      self.create!(:name => 'no user', :award => 'most groups user', :identify_id => 3)
    elsif max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most groups user')
    else 
      user.update_attributes!(:name => 'no user', :award => 'most groups user')
    end
  end
  
  #identify_id 4
  def self.get_most_activities_user
    max = -1
    max_user = User.first
    User.all.each do |user|
      num = user.activities.count
      if num > max then
        max = num
        max_user = user 
      end
    end

    user = self.find_by_identify_id(4)
    if not user then
      self.create!(:name => 'no user', :award => 'most activities user', :identify_id => 4)
    elsif max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most activities user')
    else 
      user.update_attributes!(:name => 'no user', :award => 'most activities user')
    end
  end

  #identify_id 5
  def self.get_most_liked_user
    max = -1
    max_user = User.first
    User.all.each do |user|
      num = user.users_like_me.count
      if num > max then
        max = num
        max_user = user 
      end
    end

    user = self.find_by_identify_id(5)
    if not user then
      self.create!(:name => 'no user', :award => 'most liked user', :identify_id => 5)
    elsif max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most liked user')
    else 
      user.update_attributes!(:name => 'no user', :award => 'most liked user')
    end

  end

  #identify_id 6
  def self.get_most_followed_group
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      num = group.followers.count
      if num > max then
        max = num
        max_group = group 
      end
    end

    group = self.find_by_identify_id(6)
    if not group then
      self.create!(:name => 'no group', :award => 'most followed group', :identify_id => 6)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most followed group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most followed group')
    end
  end

  #identify_id 7
  def self.get_most_members_activity
    max = -1
    max_activity = Activity.first
    Activity.all.each do |activity|
      num = activity.members.count
      if num > max then
        max = num
        max_activity = activity 
      end
    end

    activity = self.find_by_identify_id(7)
    if not activity then
      self.create!(:name => 'no activity', :award => 'most members activity', :identify_id => 7)
    elsif max_activity then
      activity.update_attributes!(:name => max_activity.title, :award => 'most members activity')
    else 
      activity.update_attributes!(:name => 'no activity', :award => 'most members activity')
    end
  end

  #identify_id 8
  def self.get_most_subscribers_activity
    max = -1
    max_activity = Activity.first
    Activity.all.each do |activity|
      num = activity.subscribers.count
      if num > max then
        max = num
        max_activity = activity 
      end
    end

    activity = self.find_by_identify_id(8)
    if not activity then
      self.create!(:name => 'no activity', :award => 'most subscribers activity', :identify_id => 8)
    elsif max_activity then
      activity.update_attributes!(:name => max_activity.title, :award => 'most subscribers activity')
    else 
      activity.update_attributes!(:name => 'no activity', :award => 'most subscribers activity')
    end
  end


  #identify_id 9
  def self.get_most_subscribers_group
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      num = group.subscribers.count
      if num > max then
        max = num
        max_group = group 
      end
    end

    group = self.find_by_identify_id(9)
    if not group then
      self.create!(:name => 'no group', :award => 'most subscribers group', :identify_id => 9)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most subscribers group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most subscribers group')
    end
  end

end
