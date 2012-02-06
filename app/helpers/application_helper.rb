module ApplicationHelper

  def secondary_scope
    return @secondary_scope
  end

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

  def resource_name
    :user
  end
   
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
     
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def user_path(user)
    profile_path(user.id)
  end

  def blog_path(blog)
    activity_blog_path(blog.activity, blog)
  end

  def picture_path(picture)
    activity_picture_path(picture.imageable, picture)
  end

  def album_path(album)
    activity_album_path(album.imageable, album)
  end
end
