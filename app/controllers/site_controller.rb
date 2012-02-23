class SiteController < ApplicationController
  before_filter :authenticate_user!, :only => [:home]
  layout :resolve_layout

  private
  def resolve_layout
    case action_name
    when "home"
      "site_home"
    else
      "site_index"
    end
  end

  public
  def index
    redirect_to home_path if user_signed_in?
    @banners = Activity.where("banner_file_name != ''").first(3)
    @activities = Activity.last(6)
    @events = Event.where("object_type != 'Comment'").order('updated_at DESC').first(25)
    @id = @events.first.id
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

  def newsfeeds
    @events = Event.where('id > ?', params[:q])
  end

end
