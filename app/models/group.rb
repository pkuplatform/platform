class Group < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  scope :readable, where("status = ?", Constant::Approved)
  scope :category, lambda{|cat| where("category_id = ?", cat.id)}

  acts_as_taggable
  acts_as_commentable

  is_impressionable

  belongs_to :category
  belongs_to :boss, :class_name=>"User"

  has_many :activities, :dependent => :destroy
  has_many :second_building_applications, :class_name => "Form::SecondBuildingApplication"
  has_many :albums, :as => :imageable
  has_many :sms, :class_name => "Sms"
  has_many :circles,    :as => :owner, :dependent => :destroy
  has_many :users,      :through => :circles

  has_attached_file :logo, :styles => { :medium => "360x268#", :card => "160x120#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"

  after_create :initialize_circles
  after_save :get_py

  def initialize_circles
    circles.create(:name => 'admin',      :status => Constant::Admin)
    circles.create(:name => 'member',     :status => Constant::Member)
    circles.create(:name => 'fan',        :status => Constant::Fan)
    circles.create(:name => 'applicant',  :status => Constant::Approving, :public=>false)
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

  def role(user)
    r = ""
    if boss == user
      r = I18n.t('group_boss')
    elsif admins.include?(user)
      r = I18n.t('group_admin')
    elsif members.include?(user)
      r = I18n.t('group_members')
    end
    r
  end

  def self.update_points
    Group.all.each do |group|
      group.points = group.pv + group.members
      group.activities.each do |activity|
        group.points += activity.points
      end
      group.save
    end
  end

  def self.hot
    Group.order("points DESC")
  end


  def self.joined(user)
    scoped.select{|a| a.members.include? user}
  end

  def self.liked(user)
    scoped.select{|a| a.fans.include? user}
  end

  def card
    logo.url(:card)
  end

  def thumb
    logo.url(:thumb)
  end

  def medium
    logo.url(:medium)
  end

  def original
    logo.url(:original)
  end

  def pv
    impressionist_count(:filter => :session_hash)
  end

  def announce
    announcement.nil? ? I18n.t('announce_empty') : announcement
  end

  define_index do
    # fields
    indexes :name, :sortable => true
    indexes :introduction
    
    # attributes
    has :created_at, :updated_at

    set_property :delta => true
  end
end
