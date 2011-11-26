class Album < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :imageable, :polymorphic => true
  has_many :pictures

end
