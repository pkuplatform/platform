class Newsfeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates_uniqueness_of :user_id, :scope => [:event_id]

  def self.update
    Event.where(:processed => false).each do |event|
      begin
        cl = class_eval(event.subject_type)
      rescue
        cl = nil
      end
      if cl.nil? 
        return nil
      end
      cl.find(event.subject_id).subscribers.each do |user|
        Newsfeed.create(:user => user, :event => event)
      end
      if event.object_type == "User" 
        Newsfeed.create(:user => User.find(event.object_id), :event => event)
      end
      event.processed = true
      event.save
    end
  end
end
