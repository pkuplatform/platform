class Activity < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

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
    title
  end

  def admin
    admins.first
  end

  define_index do
    indexes :title, :sortable => true
    indexed :description

    has :start_at, :end_at
  end

end
