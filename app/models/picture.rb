class Picture < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable
  
  belongs_to :album
  belongs_to :user
  has_attached_file :photo, :styles => { :medium => "300x300>", :small => "128x128>", :thumb => "64x64>" }
  
  after_create :new_event

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>user_id,:action=>:upload,:object_type=>"Picture",:object_id=>id)
  end

  def name
    album.title
  end

  def url
    photo.url(:thumb)
  end


end
