class Activity < ActiveRecord::Base
  belongs_to :group
  belongs_to :location
  has_many :user_activities
  has_many :users, :through => :user_activities
  has_many :comments, :as => :commentable
  has_many :albums, :as => :imageable
  has_many :tags, :as => :tagable
  has_attached_file :poster, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  has_many :admins,      :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 256 = 0"]
  has_many :members,     :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 768 = 768"]
  has_many :followers,   :through => :user_groups, :source => :user, :conditions => ["user_groups.status & 1024 = 1024"]
end
