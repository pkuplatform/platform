module ActivitiesHelper

  include ActsAsTaggableOn::TagsHelper

  def stime(activity)
    if activity.start_at.to_date == activity.end_at.to_date
      t("time:",:start_time=>activity.lstart_at,:end_time=>activity.lend_at(:only_time))
    elsif activity.start_at.year == activity.end_at.year
      t("time:",:start_time=>activity.lstart_at,:end_time=>activity.lend_at)  
    else
      t("time:",:start_time=>activity.lstart_at(:default),:end_time=>activity.lend_at(:default))
    end
  end

  def is_group_member(activity, user)
    if activity.group.members.include?(user)
      t "is_group_member"
    else
      t "not_group_member"
    end
  end

  def activity_is_public(activity)
    if activity.public?
      t "public"
    else
      t "not_public"
    end
  end

  def activity_status(activity)
    case activity.status
      when Constant::Approving
        t "approving"
      when Constant::Approved
        t "approved"
      when Constant::Blocked
        t "blocked"
      when Constant::Rejected
        t"reject"
    end
  end
end
