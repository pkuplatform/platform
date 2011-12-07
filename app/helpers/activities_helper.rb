module ActivitiesHelper
  def stime(activity)
    if activity.start_at.to_date == activity.end_at.to_date
      t("time:",:start_time=>activity.lstart_at,:end_time=>activity.lend_at(:only_time))
    elsif activity.start_at.year == activity.end_at.year
      t("time:",:start_time=>activity.lstart_at,:end_time=>activity.lend_at)  
    else
      t("time:",:start_time=>activity.lstart_at(:default),:end_time=>activity.lend_at(:default))
    end
  end
end
