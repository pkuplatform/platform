class Group < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_taggable
  acts_as_commentable

  belongs_to :category
  has_many :activities, :dependent => :destroy
  has_many :second_building_applications, :class_name => "Form::SecondBuildingApplication"
  has_many :albums, :as => :imageable
  has_many :sms, :class_name => "Sms"
  has_attached_file :logo, :styles => { :medium => "300x300#", :card => "180x180#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"

  has_many :user_groups
  has_many :members,     :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Member, Constant::Member]
  has_many :planners,    :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Planner, Constant::Planner]
  has_many :managers,    :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Manager, Constant::Manager]
  has_many :admins,      :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Admin, Constant::Admin]
  has_many :followers,   :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Like, Constant::Like]
#users tend to join
  has_many :tenders,     :through => :user_groups, :source => :user, :conditions => ["user_groups.status & ? = ?", Constant::Approving, Constant::Approving]
  has_many :subscribers, :through => :user_groups, :source => :user, :conditions => ["(user_groups.status & ? = ?) || (user_groups.status & ? = ?)", Constant::Member, Constant::Member, Constant::Like, Constant::Like]


  after_save :get_py

  def get_py
    if self.pyname!=Hz2py.do(name)
      self.pyname = Hz2py.do(name)
      save
    end
  end



  def self.daily_ranks
    ret = []
    id_arr = [1, 2, 6, 9]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def self.weekly_ranks
    ret = []
    id_arr = [10, 11, 15, 18]
    id_arr.each do |id|
      object = RankList.find_by_identify_id(id) 
      ret << object unless object.nil?
    end

    ret
  end

  def url
    logo.url(:thumb)
  end

  def admin
    admins.first || User.first
  end

  def count
    members.count + admins.count
  end

  def self.recommend
    Group.first(3)
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

  define_index do
    # fields
    indexes :name, :sortable => true
    indexes :introduction
    
    # attributes
    has :created_at, :updated_at

    #set_property :delta => true
  end
end
