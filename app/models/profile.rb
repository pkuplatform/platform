class Profile < ActiveRecord::Base

  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300#", :small => "128x128#", :thumb => "64x64#" }, :default_url => "missing_:style.jpg"
  validates_presence_of :name
  validates_presence_of :nickname
  validates_presence_of :student_id
  after_save :get_py

  define_index do
    indexes :name, :sortable => true
    indexes :nickname, :sortable => true
    indexes :description
  end

  def thumb
    avatar.url(:thumb)
  end

  def get_py
    if self.pyname!=Hz2py.do(name)
      self.pyname = Hz2py.do(name)
      save
    end
  end
end
