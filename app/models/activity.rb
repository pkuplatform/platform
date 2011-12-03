class Activity < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :group
  belongs_to :location
  has_many :albums, :as => :imageable
  has_attached_file :poster, :styles => { :big => "256x360>",:medium => "128x90>", :small => "64x90>", :thumb => "64x64>" }
  has_many :user_activities
  has_many :users, :through => :user_activities

  has_many :admins,      :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 512 = 512"]
  has_many :members,     :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 4096 = 4096"]
  has_many :followers,   :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 131072 = 131072"]

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

end
