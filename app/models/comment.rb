class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  after_create :new_event

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>user_id,:action=>:post,:object_type=>"Comment",:object_id=>id)
  end

  def url
    return commentable.url
  end

end
