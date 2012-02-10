class SiteController < ApplicationController
  before_filter :authenticate_user!, :only => [:home]
  layout "site"

  def index
    redirect_to home_path if user_signed_in?
    @activities = Activity.last(3)
    @events = Event.where("object_type != 'Comment'").order('updated_at DESC').first(5)
    @secondary_scope = nil
  end

  def home
    @newsfeeds = current_user.newsfeeds.order("id DESC")

    if @newsfeeds.empty?
      @events = Event.order('updated_at DESC').first(10)
    else
      @events = []
      @newsfeeds.each do |newsfeed|
        @events << newsfeed.event
      end
    end
  end

end
