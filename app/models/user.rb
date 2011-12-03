class User < ActiveRecord::Base

  acts_as_taggable

  has_mailbox

  # Include default devise modules. Others available are: :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :profile
  has_many :user_groups
  has_many :groups, :through => :user_groups
  has_many :user_activities
  has_many :activities, :through => :user_activities
  has_many :albums, :as => :imageable

  has_many :user_relations, :foreign_key => "liking_id", :dependent => :destroy
  has_many :users_i_like, :through => :user_relations, :source => :liked
  has_many :reverse_user_relations, :foreign_key => "liked_id", :class_name => "UserRelation", :dependent => :destroy
  has_many :users_like_me, :through => :reverse_user_relations,:source => :liking


  has_many :like_groups, :through => :user_groups, :source => :group, :conditions => ["user_groups.status & 65536 = 0"]
  has_many :like_activities, :through => :user_activities, :source => :activity, :conditions => ["user_activities.status & 65536 = 0"]

  has_many :join_groups, :through => :user_groups, :source => :group, :conditions => ["user_groups.status & 65536 = 65536"]

  def name
    profile.name
  end

  def after_initialize
    profile = Profile.new
  end

  def avatar
    profile.avatar.url(:thumb)
  end

  def like!(liked)
    user_relations.create!(:liked_id => liked.id)
  end

  def dislike!(disliked)
    user_relations.find_by_liked_id(disliked).destroy
  end
end
