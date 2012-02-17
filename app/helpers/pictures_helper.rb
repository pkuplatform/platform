module PicturesHelper
  def destroy_activity_picture_path(activity, picture)
    url_for(:controller=>:pictures, :action=>:destroy)
  end
end
