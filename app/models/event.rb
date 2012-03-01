class Event < ActiveRecord::Base
  scope :blog,     where(:object_type => 'Blog')
  scope :picture,  where(:object_type => 'Picture')
  scope :comment,  where(:object_type => 'Comment')
  scope :activity, where(:object_type => 'Activity')

  def subject_link
    begin
      cl = class_eval(subject_type)
    rescue
      nil
    end
    if not cl.nil?
     cl.find(subject_id).url
    end
  end

  def object_link
    begin
      cl = class_eval(object_type)
    rescue
      nil
    end
    if not cl.nil?
     cl.find(object_id).url
    end
  end

  def subject
    begin
      cl = class_eval(subject_type)
    rescue
      nil
    end
    if not cl.nil?
      begin
        cl.find(subject_id)
      rescue
        nil
      end
    end
  end

  def object
    begin
      cl = class_eval(object_type)
    rescue
      nil
    end
    if not cl.nil?
      begin
        cl.find(object_id)
      rescue
        nil
      end
    end
  end
end
