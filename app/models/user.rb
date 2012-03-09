class User < ActiveRecord::Base

  acts_as_taggable
  has_mailbox

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one  :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile, :allow_destroy => true
  attr_accessible :profile_attributes

  has_many :newsfeeds
  has_many :albums, :as => :imageable
  has_many :blogs, :foreign_key=>"author_id"
  has_many :pictures, :dependent => :destroy

  has_many :circles, :as => :owner, :dependent => :destroy

  has_many :user_circles, :dependent => :destroy
  has_many :belonged_circles, :through => :user_circles, :source => :circle

  has_many :user_recommends

  after_create :initialize_circles

  def initialize_circles
    circles.create(:name => 'fan',        :status => Constant::Fan)
  end

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability
  
  def fan_circle
    circles.first
  end

  def fans
    fan_circle.users
  end

  def follows
    belonged_circles.fan.collect { |c| User.find(c.owner_id) }
  end

  def activities
    belonged_circles.activities.member.collect { |c| Activity.find(c.owner_id) }
  end

  def groups
    belonged_circles.groups.member.collect { |c| Group.find(c.owner_id) }
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


  def phone
    profile.phone
  end

  def boss
    self
  end

  def thumb
    profile.avatar.url(:thumb)
  end

  def medium
    profile.medium
  end

  def description
    profile.description
  end

  def admin?
    profile.status | Constant::Super == profile.status
  end

  def friends
    fans & follows
  end

  def related_users
    (fans | follows) << self
  end

  def online?
    updated_at > 10.minutes.ago
  end

  def online_friends
    friends.delete_if { |f| not f.online? }
  end

  def self.hot
    Profile.order("points DESC")
  end

  def recommend_groups
    user_recommends.groups.order('value DESC').collect do |r| 
      gid = r.recommendable_id
      Group.find(gid) if Group.exists?(gid)
    end
  end

  def recommend_activities
    user_recommends.activities.order('value DESC').collect do |r|
      aid = r.recommendable_id
      Activity.find(aid) if Activity.exists?(aid)
    end
  end

  def realname
    profile.realname
  end

  def relation(user)
    if friends.include?(user)
      'friend'
    elsif follows.include?(user)
      'follow'
    else
      'fan'
    end
  end
end
