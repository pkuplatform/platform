class UserCircle < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle
  after_create :check_new_event

  def check_new_event
    if circle.owner.class==User
      Event.create(:subject_type=>"User",:subject_id=>user.id,:action=>:like,:object_type=>"User",:object_id=>circle.owner.id) if circle.status==Constant::Fan
    elsif circle.owner.class==Group
      Event.create(:subject_type=>"User",:subject_id=>user.id,:action=>:join,:object_type=>"Group",:object_id=>circle.owner.id) if circle.status==Constant::Member
    elsif circle.owner.class==Activity
      Event.create(:subject_type=>"User",:subject_id=>user.id,:action=>:join,:object_type=>"Activity",:object_id=>circle.owner.id) if circle.status==Constant::Member
    end
  end 

end
