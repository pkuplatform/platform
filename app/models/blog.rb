class Blog < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :author, :class_name => "User"
  belongs_to :activity

end
