class Dialog < ActiveRecord::Base
  belongs_to :channel
  belongs_to :user

  validates_presence_of :body, :channel_id, :user_id
end
