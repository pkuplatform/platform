class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :feedback_init

  def feedback_init
    @feedback = Feedback.new
    @params = {:params=>params, :cookies=>cookies, :session=>session}.to_s
  end


end
