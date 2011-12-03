class Newsfeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.update
    Event.where(:processed => false).each do |event|
      if event.subject_type == "group"
        Group.find(event.subject_id).subscribers.each do |user|
          Newsfeed.create(:user => user, :event => event)
        end
      elsif event.subject_type == "activity"
        Activity.find(event.subject_id).subscribers.each do |user|
          Newsfeed.create(:user => user, :event => event)
        end
      elsif event.subject_type == "user"
        User.find(event.subject_id).subscribers.each do |user|
          Newsfeed.create(:user => user, :event => event)
        end
      end
    end
  end
end
