class Profile < ActiveRecord::Base

  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300#", :small => "128x128#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"
end
