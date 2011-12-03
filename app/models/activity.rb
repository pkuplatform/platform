class Activity < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :group
  belongs_to :location
  has_many :albums, :as => :imageable
  has_many :user_activities
  has_many :users, :through => :user_activities
  has_attached_file :poster, :styles => { :big => "256x360#",:medium => "192x270#", :small => "64x90#", :thumb => "64x64#" }

  has_many :admins,      :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 256 = 256"]
  has_many :members,     :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 2048 = 2048"]
  has_many :followers,   :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 65536 = 65536"]
  has_many :subscribers, :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 65536 = 65536 || user_activities.status & 2048 = 2048"]

  def self.daily_ranks
    ret = []
    id_arr = [2, 7, 8]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def self.weekly_ranks
    ret = []
    id_arr = [11, 16, 17]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

=begin
  def subscribers
    ret = Set.new()
    members.each do |member|
      ret.add member
    end

    followers.each do |follower|
      ret.add follower
    end

    ret.to_a
  end
=end

end
