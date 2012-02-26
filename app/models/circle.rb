class Circle < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_many :user_circles
  has_many :users, :through => :user_circles

  scope :admin,     where(:status => Constant::Admin)
  scope :member,    where(:status => Constant::Member)
  scope :fan,       where(:status => Constant::Like)
  scope :applicant, where(:status => Constant::Approving)

  scope :user,     where(:owner_type => 'User')
  scope :group,    where(:owner_type => 'Group')
  scope :activity, where(:owner_type => 'Activity')

  def add(user)
    self.user_circles.create(:user => user)
  end

  def remove(user)
    self.user_circles.find_by_user_id(user).destroy
  end
end
