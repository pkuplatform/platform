class Group < ActiveRecord::Base
  belongs_to :category
  has_many :activities
  has_many :user_groups
  has_many :albums, :as => :imageable
  has_many :tags, :as => :tagable
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  has_many :members, :through => :user_groups, :source => :user, :conditions => ["status & 3 = 3"]
  has_many :planners, :through => :user_groups, :source => :user, :conditions => ["status & 7 = 7"]
  has_many :managers, :through => :user_groups, :source => :user, :conditions => ["status & 11 = 11"]
  has_many :admins, :through => :user_groups, :source => :user, :conditions => ["status & 15 = 15"]
end
