module AlbumsHelper
  def destroy_activity_album_path(activity, album)
    url_for(:controller=>:albums, :action=>:destroy)
  end
end
