class Profile < ActiveRecord::Base

  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300#", :small => "128x128#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"
  validates_presence_of :name
  validates_presence_of :nickname
  validates_presence_of :student_id

  define_index do
    indexes :name, :sortable => true
    indexes :nickname, :sortable => true
    indexes :description
  end

end
