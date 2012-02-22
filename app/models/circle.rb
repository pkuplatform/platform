class Circle < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_many :user_circles
  has_many :users, :through => :user_circles
end
