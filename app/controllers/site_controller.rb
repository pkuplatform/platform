class SiteController < ApplicationController
  def index
    redirect_to home_path if user_signed_in?
    @activities = Activity.last(3)
    @events = Event.order('updated_at DESC').first(5)
  end

  def home
    @newsfeeds = current_user.newsfeeds.order("id DESC")
  end

end
