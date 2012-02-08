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

  def subscribers
    a = subscribers_others.to_ary
    a << self
  end

  def name
    profile.name
  end

  def avatar(size=:small)
    profile.avatar.url(size)
  end

  def like!(liked)
    user_relations.create!(:liked_id => liked.id)
  end

  def dislike!(disliked)
    user_relations.find_by_liked_id(disliked).destroy
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
end
