module BlogsHelper
  def destroy_activity_blog_path(activity, blog)
    url_for(:controller=>:blogs, :action=>:destroy)
  end
  def blog_path(blog)
    activity_blog_path(blog.activity,blog)
  end
end
