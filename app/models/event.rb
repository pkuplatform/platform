class Event < ActiveRecord::Base
  def subject_link
    if subject_type == "group"
      return Group.find(subject_id).logo.url(:thumb)
    elsif subject_type == "activity"
      return Activity.find(subject_id).poster.url(:small)
    elsif subject_type == "user"
      return User.find(subject_id).avatar.url(:thumb)
    else
      return nil
    end
  end

  def object_link
    if object_type == "group"
      return Group.find(object_id).logo.url(:thumb)
    elsif object_type == "activity"
      return Activity.find(object_id).poster.url(:small)
    elsif object_type == "user"
      return User.find(object_id).avatar.url(:thumb)
    else
      return nil
    end
  end

  def subject
    if subject_type == "group"
      return Group.find(subject_id)
    elsif subject_type == "activity"
      return Activity.find(subject_id)
    elsif subject_type == "user"
      return User.find(subject_id)
    else
      return nil
    end
  end

  def object
    if object_type == "group"
      return Group.find(object_id)
    elsif object_type == "activity"
      return Activity.find(object_id)
    elsif object_type == "user"
      return User.find(object_id)
    else
      return nil
    end
  end
end
