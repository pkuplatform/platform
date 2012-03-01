class Circle < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_many :user_circles, :dependent => :destroy
  has_many :users, :through => :user_circles

  validates_presence_of :name

  scope :admin,     where(:status => Constant::Admin)
  scope :member,    where(:status => Constant::Member)
  scope :fan,       where(:status => Constant::Fan)
  scope :follow,    where(:status => Constant::Follow)
  scope :applicant, where(:status => Constant::Approving)

  scope :users,     where(:owner_type => 'User')
  scope :groups,    where(:owner_type => 'Group')
  scope :activities, where(:owner_type => 'Activity')

  after_initialize :get_mode_str
  attr_accessor :mode_str

  def get_mode_str
    @mode_str = mode.to_s(8)
  end

  def add(user)
    self.user_circles.create(:user => user)
  end

  def remove(user)
    self.user_circles.find_by_user_id(user).destroy
  end

  def self.writable(user)
    scoped.select{|c| user.can? :write, c}
  end
  def self.readable(user)
    scoped.select{|c| user.can? :read, c}
  end
  def self.deletable(user)
    scoped.select{|c| user.can? :delete,c}
  end

end
