class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :feedback_init
  before_filter :store_location
  before_filter :init_secondary_scope

  def init_secondary_scope
    @secondary_scope = params[:controller] unless params[:controller] == "site"
  end

  def feedback_init
    @feedback = Feedback.new
    @params = {:params=>params, :cookies=>cookies, :session=>session}.to_s
  end

  def store_location
    session[:user_return_to]  = request.url unless params[:controller] == "devise/sessions"
  end


  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || home_path
  end
end
