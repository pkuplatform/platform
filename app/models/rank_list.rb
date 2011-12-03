class RankList < ActiveRecord::Base
  validates :identify_id, :uniqueness => true

  def self.get_rank
    get_most_member_group
    get_most_activity_group
    get_most_group_user
    get_most_activities_user
    get_most_liked_user
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
    if group and max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most users group')
    else
      self.create!(:name => 'no group', :award => 'most users group', :identify_id => 1)
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
    if group and max_group then
      group.update_attributes!(:name => max_group.name, :award => 'most activities group')
    else
      self.create!(:name => 'no group',  :award => 'most activities group', :identify_id => 2)
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
    if user and max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most groups user')
    else
      self.create!(:name => 'no user', :award => 'most groups user', :identify_id => 3)
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
    if user and max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most activities user')
    else
      self.create!(:name => 'no user', :award => 'most activities user', :identify_id => 4)
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
    if user and max_user then
      user.update_attributes!(:name => max_user.name, :award => 'most liked user')
    else
      self.create!(:name => 'no user', :award => 'most liked user', :identify_id => 1)
    end
  end

end
