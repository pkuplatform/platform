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
  has_many :user_activities
  has_many :users, :through => :user_activities
  has_attached_file :poster, :styles => { :medium => "256x360#",:card => "180x250#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"
  has_attached_file :banner, :styles => { :medium => "576x320#", :banner => "180x100#" }

  has_many :admins,      :through => :user_activities, :source => :user, :conditions => ["user_activities.status & ? = ?", Constant::Admin, Constant::Admin]
  has_many :members,     :through => :user_activities, :source => :user, :conditions => ["user_activities.status & ? = ?", Constant::Member, Constant::Member]
  has_many :followers,   :through => :user_activities, :source => :user, :conditions => ["user_activities.status & ? = ?", Constant::Like, Constant::Like]
#users tend to join
  has_many :tenders,     :through => :user_activities, :source => :user, :conditions => ["user_activities.status & ? = ?", Constant::Approving, Constant::Approving]
  has_many :subscribers, :through => :user_activities, :source => :user, :conditions => ["(user_activities.status & ? = ?) || (user_activities.status & ? = ?)", Constant::Member, Constant::Member, Constant::Like, Constant::Like]

  has_many :circles, :as => :owner

  has_many :users, :through => :user_activities

  after_save :get_py

  after_create :initialize_circles

  def initialize_circles
    self.circles.create(:name=>I18n.t('member'),:status=> Constant::Member, :deletable=>false)
    self.circles.create(:name=>I18n.t('admin'),:status=> Constant::Admin, :deletable=>false)
  end

  def default_circle
    circles.first
  end

  def related_users
    members
  end

  def get_py
    if self.pyname!=Hz2py.do(name)
      self.pyname = Hz2py.do(name)
      save
    end
  end


  def self.daily_ranks
    ret = []
    id_arr = [2, 7, 8]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end
    ret
  end

  def self.weekly_ranks
    ret = []
    id_arr = [11, 16, 17]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def url
    poster.url(:thumb)
  end

  def name
    title || ""
  end

  def admin
    admins.first
  end

  def persons
    admins | members
  end

  def person_cnt
    admins.count + members.count
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

  def self.recommend
    Activity.order("points DESC").first(3)
  end

  def self.hot
    Activity.order("points DESC").first(3)
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
