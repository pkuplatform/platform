module ApplicationHelper

  def format_datetime(time)
    time.strftime('%y-%m-%d') + " " + time.strftime('%H:%M')
  end

  def is_current_user
    current_user.id == params[:id].to_i
  end

  def approved?(object)
    (object.status & Constant::Approved) == Constant::Approved
  end

  def rejected?(object)
    (object.status & Constant::Rejected) == Constant::Rejected
  end

  def approving?(object)
    (object.status & Constant::Approving) == Constant::Approving
  end

end
