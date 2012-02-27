class Group < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_taggable
  acts_as_commentable

  is_impressionable

  belongs_to :category

  has_many :activities, :dependent => :destroy
  has_many :second_building_applications, :class_name => "Form::SecondBuildingApplication"
  has_many :albums, :as => :imageable
  has_many :sms, :class_name => "Sms"
  has_many :circles,    :as => :owner
  has_many :users,      :through => :circles

  has_attached_file :logo, :styles => { :medium => "300x300#", :card => "180x180#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"

  after_create :initialize_circles
  after_save :get_py

  def initialize_circles
    circles.create(:name => 'admin',      :status => Constant::Admin,     :mode => 0644)
    circles.create(:name => 'member',     :status => Constant::Member,    :mode => 0644)
    circles.create(:name => 'fan',        :status => Constant::Like,      :mode => 0444)
    circles.create(:name => 'applicant',  :status => Constant::Approving, :mode => 0440)
  end

  def members
    member_circle.users
  end

  def admins
    admin_circle.users
  end

  def fans
    fan_circle.users
  end

  def applicants
    applicant_circle.users
  end

  def member_circle
    circles.member.first
  end

  def admin_circle
    circles.admin.first
  end

  def fan_circle
    circles.fan.first
  end

  def applicant_circle 
    circles.applicant.first
  end

  def subscribers
    members | admins | followers
  end

  def get_py
    if self.pyname!=Hz2py.do(name)
      self.pyname = Hz2py.do(name)
      save
    end
  end

  def default_circle
    circles.first
  end

  def url
    logo.url(:thumb)
  end

  def admin
    admins.first || User.first
  end

  def persons
    admins | members
  end

  def role(user)
    r = ""
    if members.include?(user)
      r = I18n.t('member')
    elsif admin == user
      r = I18n.t('group_boss')
    elsif admins.include?(user)
      r = I18n.t('admin')
    end
    r
  end

  def self.update_points
    Group.all.each do |group|
      group.points = group.pv + group.person_cnt
      group.activities.each do |activity|
        group.points += activity.points
      end
      group.save
    end
  end

  def self.recommend
    Group.order("points DESC").first(3)
  end

  def self.hot
    Group.order("points DESC").first(3)
  end

  def card
    logo.url(:card)
  end

  def thumb
    logo.url(:thumb)
  end

  def pv
    impressionist_count(:filter => :session_hash)
  end

  define_index do
    # fields
    indexes :name, :sortable => true
    indexes :introduction
    
    # attributes
    has :created_at, :updated_at

    #set_property :delta => true
  end
end
