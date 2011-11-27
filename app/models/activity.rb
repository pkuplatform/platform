class Activity < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :group
  belongs_to :location
  has_many :user_activities
  has_many :users, :through => :user_activities
  has_many :albums, :as => :imageable
  has_attached_file :poster, :styles => { :medium => "300x300>", :small => "128x128>", :thumb => "100x100>" }

  has_many :admins,      :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 256 = 0"]
  has_many :members,     :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 768 = 768"]
  has_many :followers,   :through => :user_activities, :source => :user, :conditions => ["user_activities.status & 1024 = 1024"]
end
