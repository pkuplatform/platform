class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :feedback_init
  before_filter :store_location
  before_filter :init_secondary_scope

  def init_secondary_scope
    val = params[:controller]
    if val == "sms" or val == "form/second_building_applications"
      @secondary_scope = "groups"
    elsif val == "mailboxes"
      @secondary_scope = "profiles"
    elsif val == "site"
      @secondary_scope = nil
    else
      @secondary_scope = params[:controller]
    end
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
