class UserActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  validates_uniqueness_of :user_id, :scope => [:activity_id]
  after_create :ifpublic

  def ifpublic
    if self.public
      UserCircle.create(:user=>self.user,:circle=>self.activity.default_circle)
    end
  end

end
