class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :store_location
  after_filter :user_status

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
    @tags = ActsAsTaggableOn::Tag.select("name").where("name like ?", "#{params[:q]}%")
    respond_to do |format|
      format.json { render :json => @tags }
    end
  end

end
