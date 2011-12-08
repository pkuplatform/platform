class Group < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :category
  has_many :activities
  has_many :second_building_applications, :class_name => "Form::SecondBuildingApplication"
  has_many :albums, :as => :imageable
  has_many :tags, :as => :tagable
  has_attached_file :logo, :styles => { :medium => "300x300#", :small => "128x128#", :thumb => "64x64#" }

  has_many :user_groups
  has_many :members,     :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Member, Constant::Member]
  has_many :planners,    :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Planner, Constant::Planner]
  has_many :managers,    :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Manager, Constant::Manager]
  has_many :admins,      :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Admin, Constant::Admin]
  has_many :followers,   :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Like, Constant::Like]
  has_many :subscribers,   :through => :user_groups, :source => :user, :conditions => ["(user_groups.status & ? = ?) || (user_groups.status & ? = ?)", Constant::Member, Constant::Member, Constant::Like, Constant::Like]

  def self.daily_ranks
    ret = []
    id_arr = [1, 2, 6, 9]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def self.weekly_ranks
    ret = []
    id_arr = [10, 11, 15, 18]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def self.weekly_ranks
    ret = []
    id_arr = [10, 11, 15, 18]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def url
    logo.url(:thumb)
  end

end
