class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
