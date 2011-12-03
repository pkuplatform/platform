class UserRelation < ActiveRecord::Base
  belongs_to :liking, :class_name => "User"
  belongs_to :liked,  :class_name => "User"

  validates :liking_id, :presence => true
  validates :liked_id,  :presence => true

end
