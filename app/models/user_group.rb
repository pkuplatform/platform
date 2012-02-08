class UserGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => [:group_id]

  def self.f(group, user)
    find_by_group_id_and_user_id(group, user)
  end

  def set(s)
    self.status = s.to_i
    self.save
    
    Event.create(:subject_type => "User", :subject_id => user_id, :action => "join", :object_type => "Group", :object_id => group_id) if s == Constant::Approved
  end
end
