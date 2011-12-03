module ApplicationHelper

  def format_datetime(time)
    time.strftime('%y-%m-%d') + " " + time.strftime('%H:%M')
  end

  def is_current_user
    current_user.id == params[:id].to_i
  end

end
