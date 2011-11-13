class Activity < ActiveRecord::Base
  belongs_to :group
  belongs_to :location
  has_many :users, :through => :user_activities
  has_many :comments, :as => :commentable
  has_many :albums, :as => :imageable
  has_many :tags, :as => :tagable
  has_attached_file :poster, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
