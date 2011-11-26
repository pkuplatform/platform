class Picture < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable
  
  belongs_to :album
  belongs_to :user
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
