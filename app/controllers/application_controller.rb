class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :store_location
  after_filter :user_status
  before_filter :build_crumbs

  helper_method :picture_path, :picture_url

  def picture_path(picture,params={})
    url_for([picture.imageable, picture])
  end

  def build_crumbs
    @crumbs=[]
  end

  def set_locale
    I18n.locale = "zh-CN"
  end

  def user_status
    current_user.try :touch
  end
  
  def store_location
    session[:user_return_to]  = request.url unless params[:controller] == "devise/sessions" or params[:controller] == "site" and params[:view] == "newsfeeds"
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || home_path
  end

  def tags
    @tags = ActsAsTaggableOn::Tag.select("name").where("lower(name) like ?","#{params[:q]}%")
    @tags |= ActsAsTaggableOn::Tag.select("name").all.select{|t|Hz2py.do(t.name).score(params[:q])>0.7} if @tags.count < 5
    respond_to do |format|
      format.json { render :json => @tags }
    end
  end

end
