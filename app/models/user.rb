class User < ActiveRecord::Base
  has_mailbox

  # Include default devise modules. Others available are: :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :profile
  has_many :groups, :through => :user_groups
  has_many :activities, :through => :user_activities
  has_many :albums, :as => :imageable
end
