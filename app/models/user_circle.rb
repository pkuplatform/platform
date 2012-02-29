class UserCircle < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle
  after_create :check_applicant
  before_destroy :check_member

  def check_applicant
    if circle.owner.applicants.include?(user)&&circle.status!=Constant::Approving
      circle.owner.applicant_circle.remove(user)
      circle.owner.member_circle.add(user) unless circle.owner.members.include?(user)
    end
  end
  def check_member
    if circle.status==Constant::Member && circle.owner.admins.include?(user)
      return false
    end
  end
end
