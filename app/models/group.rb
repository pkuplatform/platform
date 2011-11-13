class Group < ActiveRecord::Base
  belongs_to :category
  has_many :activities
  has_many :users, :through => :user_groups
  has_many :albums, :as => :imageable
  has_many :tags, :as => :tagable
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
