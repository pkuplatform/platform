class RankList < ActiveRecord::Base

  def self.get_rank
    get_most_member_group
    get_most_activity_group
    get_most_group_user
    get_most_activities_user
    get_most_liked_user
  end

  #id 1
  def get_most_member_group
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      num = group.members.count
      if num > max then
        max = num
        max_group = group
      end
    end
    group = self.find(1)
    
    if not group.nil? then
      group.update_attributes!(:name => max_group.name, :award => '人数最多的社团')
    end
  end

  def get_most_activity_group
    max = -1
    max_group = Group.first
    Group.all.each do |group|
      num = group.activities.count
      if num > max then
        max = num
        max_group = group
      end
    end
    self.create!(:name => max_group.name, :award => '活动最多的社团')
  end

  def get_most_group_user
    max = -1
    max_user = User.first
    User.all.each do |user|
      num = user.groups.count
      if num > max then
        max = num
        max_user = user 
      end
    end
    self.create!(:name => max_user.name, :award => '参加社团最多的人')
  end
  
  def get_most_activities_user
    max = -1
    max_user = User.first
    User.all.each do |user|
      num = user.activities.count
      if num > max then
        max = num
        max_user = user 
      end
    end
    self.create!(:name => max_user.name, :award => '参加活动最多的人')
  end

  def get_most_liked_user
    max = -1
    max_user = User.first
    User.all.each do |user|
      num = user.users_like_me.count
      if num > max then
        max = num
        max_user = user 
      end
    end
    self.create!(:name => max_user.name, :award => '最被大家喜欢的人')
  end
end
