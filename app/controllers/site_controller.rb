class SiteController < ApplicationController
  def index
    redirect_to home_path if user_signed_in?
    @activities = Activity.last(3)
  end

  def home
  end

end
