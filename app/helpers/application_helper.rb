module ApplicationHelper

  def navi
    if @navi == :default
      params[:controller]+"/navi"
    elsif @navi
      @navi
    else
      "share/navi"
    end
  end

  def anchorgen
    
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

  def destroy_comment_path(comment)
    url_for(:id => comment.id,:controller=>:comments, :action=>:destroy)
  end

  def event_exist?(event)
    true
    #not (event.subject.nil? || event.object.nil?)
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
    profile_path(user.profile.id)
  end

  def blog_path(blog)
    activity_blog_path(blog.activity, blog)
  end

  def picture_path(picture)
    activity_picture_path(picture.imageable, picture)
  end

  def load_picture_path(picture)
    load_activity_picture_path(picture.imageable, picture)
  end

  def album_path(album)
    activity_album_path(album.imageable, album)
  end

  def chops(options)
    ops = []
    options.each do |op|
      if op == "Delete"
        ops << [t("delete"), "Delete"]
      elsif op == "Undelete"
        ops << [t("undelete"), "Undelete"]
      elsif op == "Read"
        ops << [t("read"), "Read"]
      elsif op == "Unread"
        ops << [t("unread"), "Unread"]
      end
    end
    ops
  end

  def new_messages
      msgs = current_user.inbox.find_all_by_opened(false)
      new_message_count = msgs.count - (current_user.profile.unread_message_count || 0)
      if (new_message_count>0)
        msgs = msgs.first(new_message_count)
      else 
        []
      end
  end

  def dismark_new_messages
      puts current_user.profile.update_attributes!(unread_message_count: current_user.inbox.find_all_by_opened(false).count)
  end

end
