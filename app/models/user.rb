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

  has_many :newsfeeds
  has_many :albums, :as => :imageable
  has_many :blogs, :foreign_key=>"author_id"
  has_many :pictures, :dependent => :destroy

  has_many :circles, :as => :owner

  has_many :user_circles
  has_many :belonged_circles, :through => :user_circles, :source => :circle

  has_many :user_recommends

  after_create :initialize_circles

  def initialize_circles
    circles.create(:name => 'fan',        :status => Constant::Like,      :mode => 0444)
  end

  def fans
    circles.fan.first.users
  end

  def follows
    belonged_circles.user.collect { |c| User.find(c.owner_id) }
  end

  def activities
    belonged_circles.activity.collect { |c| Activity.find(c.owner_id) }
  end

  def groups
    belonged_circles.group.collect { |c| Group.find(c.owner_id) }
  end

  def subscribers
    fans
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
    fans & follows
  end

  def persons
    fans | follows
  end

  def online?
    updated_at > 10.minutes.ago
  end

  def online_friends
    friends.delete_if { |f| not f.online? }
  end

  def recommend_groups
    user_recommends.group.order('value DESC').collect do |r| 
      gid = r.recommendable_id
      Group.find(gid) if Group.exists?(gid)
    end
  end

  def recommend_activities
    user_recommends.activity.order('value DESC').collect do |r|
      aid = r.recommendable_id
      Activity.find(aid) if Activity.exists?(aid)
    end
  end
end
