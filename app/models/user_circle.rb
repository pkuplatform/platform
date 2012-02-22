class UserCircle < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle
end
