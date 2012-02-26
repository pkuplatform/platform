class Channel < ActiveRecord::Base
  has_many :dialogs, :dependent => :destroy
end
