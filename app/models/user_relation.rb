class UserRelation < ActiveRecord::Base
  belongs_to :liking, :class_name => "User"
  belongs_to :liked,  :class_name => "User"

  validates :liking_id, :presence => true
  validates :liked_id,  :presence => true

  after_create :new_event

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>liking_id,:action=>:like,:object_type=>"User",:object_id=>liked_id)
  end

end
