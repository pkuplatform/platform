class RankList < ActiveRecord::Base
  validates :identify_id, :uniqueness => true

  def self.get_daily_rank
    get_most_member_group(1, 1) #1
    get_most_activity_group(1, 2) #2
    get_most_group_user(1, 3) #3
    get_most_activities_user(1, 4) #4
    get_most_liked_user(1, 5) #5
    get_most_followed_group(1, 6) #6
    get_most_members_activity(1, 7) #7
    get_most_subscribers_activity(1, 8) #8
    get_most_subscribers_group(1, 9) #9
  end

  def self.get_weekly_rank
    get_most_member_group(7, 10) #10
    get_most_activity_group(7, 11) #11
    get_most_group_user(7, 12) #12
    get_most_activities_user(7, 13) #13
    get_most_liked_user(7, 14) #14
    get_most_followed_group(7, 15) #15
    get_most_members_activity(7, 16) #16
    get_most_subscribers_activity(7, 17) #17
    get_most_subscribers_group(7, 18) #18
  end

private
  #identify_id 1
  def self.get_most_member_group(days_ago, id)
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      previous_num = group.members.where("user_groups.updated_at < ?", days_ago.days.ago).count
      num = group.members.count - previous_num
      if num > max then
        max = num
        max_group = group
      end
    end

    group = self.find_by_identify_id(id)
    if not group then
      self.create!(:name => 'no group', :award => 'most_members_group', :identify_id => id)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most members group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most members group')
    end
  end

  #identify_id 2
  def self.get_most_activity_group(days_ago, id)
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      previous_num = group.activities.where("activities.updated_at < ?", days_ago.days.ago).count
      num = group.activities.count - previous_num
      if num > max then
        max = num
        max_group = group
      end
    end

    group = self.find_by_identify_id(id)
    if not group then
      self.create!(:name => 'no group', :award => 'most activities group', :identify_id => id)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most activities group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most activities group')
    end
  end
  
  #identify_id 3
  def self.get_most_group_user(days_ago, id)
    max = -1
    max_user = User.first
    User.all.each do |user|
      previous_num = user.groups.where("user_groups.updated_at < ?", days_ago.days.ago).count
      num = user.groups.count - previous_num
      if num > max then
        max = num
        max_user = user 
      end
    end

    user = self.find_by_identify_id(id)
    if not user then
      self.create!(:name => 'no user', :award => 'most groups user', :identify_id => id)
    elsif max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most groups user')
    else 
      user.update_attributes!(:name => 'no user', :award => 'most groups user')
    end
  end
  
  #identify_id 4
  def self.get_most_activities_user(days_ago, id)
    max = -1
    max_user = User.first
    User.all.each do |user|
      previous_num = user.activities.where("user_activities.updated_at < ?", days_ago.days.ago).count
      num = user.activities.count - previous_num
      if num > max then
        max = num
        max_user = user 
      end
    end

    user = self.find_by_identify_id(id)
    if not user then
      self.create!(:name => 'no user', :award => 'most activities user', :identify_id => id)
    elsif max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most activities user')
    else 
      user.update_attributes!(:name => 'no user', :award => 'most activities user')
    end
  end

  #identify_id 5
  def self.get_most_liked_user(days_ago, id)
    max = -1
    max_user = User.first
    User.all.each do |user|
      previous_num = user.users_like_me.where("user_relations.updated_at < ?", days_ago.days.ago).count
      num = user.users_like_me.count - previous_num
      if num > max then
        max = num
        max_user = user 
      end
    end

    user = self.find_by_identify_id(id)
    if not user then
      self.create!(:name => 'no user', :award => 'most liked user', :identify_id => id)
    elsif max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most liked user')
    else 
      user.update_attributes!(:name => 'no user', :award => 'most liked user')
    end

  end

  #identify_id 6
  def self.get_most_followed_group(days_ago, id)
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      previous_num = group.followers.where("user_groups.updated_at < ?", days_ago.days.ago).count
      num = group.followers.count - previous_num
      if num > max then
        max = num
        max_group = group 
      end
    end

    group = self.find_by_identify_id(id)
    if not group then
      self.create!(:name => 'no group', :award => 'most followed group', :identify_id => id)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most followed group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most followed group')
    end
  end

  #identify_id 7
  def self.get_most_members_activity(days_ago, id)
    max = -1
    max_activity = Activity.first
    Activity.all.each do |activity|
      previous_num = activity.members.where("user_activities.updated_at < ?", days_ago.days.ago).count
      num = activity.members.count - previous_num
      if num > max then
        max = num
        max_activity = activity 
      end
    end

    activity = self.find_by_identify_id(id)
    if not activity then
      self.create!(:name => 'no activity', :award => 'most members activity', :identify_id => id)
    elsif max_activity then
      activity.update_attributes!(:name => max_activity.title, :award => 'most members activity')
    else 
      activity.update_attributes!(:name => 'no activity', :award => 'most members activity')
    end
  end

  #identify_id 8
  def self.get_most_subscribers_activity(days_ago, id)
    max = -1
    max_activity = Activity.first
    Activity.all.each do |activity|
      previous_num = activity.subscribers.where("user_activities.updated_at < ?", days_ago.days.ago).count
      num = activity.subscribers.count - previous_num
      if num > max then
        max = num
        max_activity = activity 
      end
    end

    activity = self.find_by_identify_id(id)
    if not activity then
      self.create!(:name => 'no activity', :award => 'most subscribers activity', :identify_id => id)
    elsif max_activity then
      activity.update_attributes!(:name => max_activity.title, :award => 'most subscribers activity')
    else 
      activity.update_attributes!(:name => 'no activity', :award => 'most subscribers activity')
    end
  end


  #identify_id 9
  def self.get_most_subscribers_group(days_ago, id)
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      previous_num = group.subscribers.where("user_groups.updated_at < ?", days_ago.days.ago).count
      num = group.subscribers.count - previous_num
      if num > max then
        max = num
        max_group = group 
      end
    end

    group = self.find_by_identify_id(id)
    if not group then
      self.create!(:name => 'no group', :award => 'most subscribers group', :identify_id => id)
    elsif max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most subscribers group')
    else 
      group.update_attributes!(:name => 'no group', :award => 'most subscribers group')
    end
  end

end
