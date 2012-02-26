class Profile < ActiveRecord::Base

  is_impressionable

  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300#", :small => "128x128#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"
  validates_presence_of :name
  validates_presence_of :nickname
  validates_presence_of :student_id
  validates_uniqueness_of :nickname
  validates_uniqueness_of :student_id
  validates_uniqueness_of :phone
  after_save :get_py

  define_index do
    indexes :name, :sortable => true
    indexes :nickname, :sortable => true
    indexes :description
  end

  def medium
    avatar.url(:medium)
  end

  def card
    avatar.url(:small)
  end

  def thumb
    avatar.url(:thumb)
  end

  def self.recommend
    Profile.order("points DESC").first(3)
  end

  def self.update_points
    Profile.all.each do |profile|
      user = profile.user
      profile.points = profile.pv + user.groups.count + user.activities.count + user.users_i_like + 2 * user.users_like_me
      profile.save
    end
  end

  def pv
    impressionist_count(:filter => :session_hash)
  end

  def get_py
    if self.pyname!=Hz2py.do(name)
      self.pyname = Hz2py.do(name)
      save
    end
  end
end
