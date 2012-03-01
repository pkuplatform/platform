class UserCircle < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle
  after_create :check_applicant
  after_create :check_new_event
  before_destroy :check_member

  def check_applicant
    if circle.owner.applicants.include?(user)&&circle.status!=Constant::Approving
      circle.owner.applicant_circle.remove(user)
      circle.owner.member_circle.add(user) unless circle.owner.members.include?(user)
    end
  end

  def check_new_event
    if circle.owner.class==User
      Event.create(:subject_type=>"User",:subject_id=>user.id,:action=>:like,:object_type=>"User",:object_id=>circle.owner.id) if circle.status==Constant::Like
    elsif circle.owner.class==Group
      Event.create(:subject_type=>"User",:subject_id=>user.id,:action=>:join,:object_type=>"Group",:object_id=>circle.owner.id) if circle.status==Constant::Member
    elsif circle.owner.class==Activity
      Event.create(:subject_type=>"User",:subject_id=>user.id,:action=>:join,:object_type=>"Activity",:object_id=>circle.owner.id) if circle.status==Constant::Member
    end
  end
      

  def check_member
    if circle.status==Constant::Member && circle.owner.admins.include?(user)
      return false
    elsif circle.status==Constant::Member
      circle.owner.circles.where('status != ?',Constant::Like).each do |c|
        uc = c.user_circles.find_by_user_id(user)
        uc.delete unless uc.nil?
      end
    end
  end
end
