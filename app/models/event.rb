class Event < ActiveRecord::Base
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
     cl.find(subject_id)
    end
  end

  def object
    begin
      cl = class_eval(object_type)
    rescue
      nil
    end
    if not cl.nil?
     cl.find(object_id)
    end
  end
end
