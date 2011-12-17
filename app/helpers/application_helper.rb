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

  def comment_path(comment)
    url_for(comment.commentable)+"#comment-#{comment.id}"
  end

  def event_exist?(event)
    not (event.subject.nil? || event.object.nil?)
#    class_eval(event.object_type).all.include?(event.object) && class_eval(event.subject_type).all.include?(event.subject)
  end


end
