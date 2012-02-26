class User < ActiveRecord::Base

  acts_as_taggable
  has_mailbox

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one  :profile
  accepts_nested_attributes_for :profile, :allow_destroy => true
  attr_accessible :profile_attributes

  has_many :user_groups
  has_many :groups, :through => :user_groups
  has_many :join_groups, :through => :user_groups, :source => :group, :conditions => ["user_groups.status & ? = ?", Constant::Member, Constant::Member]
  has_many :like_groups, :through => :user_groups, :source => :group, :conditions => ["user_groups.status & ? = ?", Constant::Like, Constant::Like]

  has_many :user_activities
  has_many :activities, :through => :user_activities
  has_many :join_activities, :through => :user_activities, :source => :activity, :conditions => ["user_activities.status & ? = ?", Constant::Member, Constant::Member]
  has_many :like_activities, :through => :user_activities, :source => :activity, :conditions => ["user_activities.status & ? = ?", Constant::Like, Constant::Like]

  has_many :newsfeeds
  has_many :albums, :as => :imageable
  has_many :blogs, :foreign_key=>"author_id"

  has_many :user_relations, :foreign_key => "liking_id", :dependent => :destroy
  has_many :users_i_like, :through => :user_relations, :source => :liked
  has_many :subscribers_others, :through => :user_relations, :source => :liked
  has_many :reverse_user_relations, :foreign_key => "liked_id", :class_name => "UserRelation", :dependent => :destroy
  has_many :users_like_me, :through => :reverse_user_relations,:source => :liking

  has_many :pictures, :dependent => :destroy

  has_many :circles, :as => :owner

  has_many :user_circles
  has_many :belonged_circles, :through => :user_circles, :source => :circle

  def users
    User.all
  end

  def subscribers
    a = subscribers_others.to_ary
    a << self
  end

  def name
    if profile.nil?
      return ""
    else
      return profile.name || ""
    end
  end

  def avatar(size=:small)
    profile.avatar.url(size)
  end

  def self.daily_ranks
    RankList.where("identify_id < ?", 10)
  end

  def self.weekly_ranks
    RankList.where("identify_id > ? && identify_id < ?", 9, 19)
  end

  def url(size = :thumb)
    profile.avatar.url(size)
  end

  def nickname
    profile.nickname
  end

  def phone
    profile.phone
  end

  def thumb
    profile.avatar.url(:thumb)
  end

  def admin?
    profile.status | Constant::Super == profile.status
  end

  def friends
    users_i_like & users_like_me
  end

  def online?
    updated_at > 10.minutes.ago
  end

  def online_friends
    friends.delete_if { |f| not f.online? }
  end

  def recommend_groups
    groups = Array.new
    UserRecommend.select('recommendable_id as rid').where(:user_id => id, :recommendable_type => "Group").order('value DESC').each do |g|
      groups << Group.find(g.rid) if Group.exists?(g.rid)
    end
    groups
  end

  def recommend_activities
    activities = Array.new
    UserRecommend.select('recommendable_id as rid').where(:user_id => id, :recommendable_type => "Activity").order('value DESC').each do |a|
      activities << Activity.find(a.rid) if Activity.exists?(a.rid)
    end
    activities
  end
end
