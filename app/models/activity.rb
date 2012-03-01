class Activity < ActiveRecord::Base

  validates_presence_of :group_id
  validates_presence_of :location
  validates_presence_of :title

  acts_as_taggable
  acts_as_commentable

  is_impressionable

  belongs_to :group

  has_many :albums, :as => :imageable
  has_many :pictures, :through => :albums
  has_many :blogs, :dependent => :destroy
  has_many :circles, :as => :owner, :dependent => :destroy
  has_many :users, :through => :circles

  has_attached_file :poster, :styles => { :medium => "360x268#",:card => "160x120#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"
  has_attached_file :banner, :styles => { :medium => "576x320#", :banner => "180x100#" }, :default_url => "missing_:style.jpg"

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

  def url
    poster.url(:thumb)
  end

  def name
    title || ""
  end

  def admin
    admins.first || User.first
  end

  def persons
    admins | members
  end

  def thumb
    poster.url(:thumb)
  end

  def card
    poster.url(:card)
  end

  def medium
    poster.url(:medium)
  end

  def self.update_points
    Activity.all.each do |activity|
      activity.points = activity.pv + activity.person_cnt
                        + activity.followers.count 
                        + activity.blogs.count * 5 
                        + activity.pictures.count * 3
    end
  end

  def self.hot
    Activity.order("points DESC")
  end

  def pv
    impressionist_count(:filter => :session_hash)
  end

  def role(user)
    r = ""
    if members.include?(user)
      r = I18n.t('activity_member')
    elsif admin == user
      r = I18n.t('activity_boss')
    elsif admins.include?(user)
      r = I18n.t('activity_admin')
    end
    r
  end

  define_index do
    indexes :title, :sortable => true
    indexed :description

    has :start_at, :end_at
  end

end
