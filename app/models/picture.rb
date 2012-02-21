class Picture < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable
  
  belongs_to :album
  belongs_to :user
  has_attached_file :photo, :styles => { :big=>"600x600>",:medium => "300x300>", :small => "128x128>", :thumb => "64x64>" }
  
  after_create :new_event

  def new_event
    Event.create(:subject_type=>"User",:subject_id=>user_id,:action=>:upload,:object_type=>"Picture",:object_id=>id)
  end

  def name
    album.title + "(#{album.imageable.name})"
  end

  def bare_name
    album.title
  end

  def url(size=:thumb)
    photo.url(size)
  end

  def medium
    url(:medium)
  end

  def thumb
    url(:thumb)
  end

  def imageable
    album.imageable
  end

  def prev
    album.pictures[(album.pictures.find_index(self)-1) % album.pictures.count]
  end

  def next
    album.pictures[(album.pictures.find_index(self)+1) % album.pictures.count]
  end
end
