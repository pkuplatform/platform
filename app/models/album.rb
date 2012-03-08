class Album < ActiveRecord::Base

  acts_as_taggable
  acts_as_commentable

  belongs_to :imageable, :polymorphic => true
  has_many :pictures, :dependent => :destroy

  validates_presence_of :title

  def cover
    if pictures.first.nil?
      return Picture.first
    else
      return pictures.first
    end
  end

  def small
    cover.url(:small)
  end

end
