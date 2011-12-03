class Group < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :category
  has_many :activities
  has_many :user_groups
  has_many :albums, :as => :imageable
  has_many :tags, :as => :tagable
  has_attached_file :logo, :styles => { :medium => "300x300>", :small => "128x128>", :thumb => "64x64>" }

  has_many :test, :through => :user_groups, :source => :user
  has_many :members,     :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 768 = 768"]
  has_many :planners,    :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 512 = 512"]
  has_many :managers,    :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 256 = 256"]
  has_many :admins,      :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 256 = 0"]
  has_many :followers,   :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 1024 = 1024"]
  has_many :subscribers,  :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 0 = 0"]
end
