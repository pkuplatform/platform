class Blog < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :author, :class_name => "User"
  belongs_to :activity

  after_create :new_event

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>author_id,:action=>:create,:object_type=>"Blog",:object_id=>id)
  end

  def name
    return title+"(#{activity.name})"
  end

  def bare_name
    return title
  end

  def url
    return activity.url
  end

end
