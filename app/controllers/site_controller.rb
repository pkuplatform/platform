class SiteController < ApplicationController
  before_filter :authenticate_user!, :only => [:home]

  def index
    redirect_to home_path if user_signed_in?
    @activities = Activity.last(3)
    @events = Event.where("object_type != 'Comment'").order('updated_at DESC').first(5)
  end

  def home
    if current_user.profile.nil?
      @profile=Profile.new
      @profile.user = current_user
      @profile.save
      redirect_to edit_profile_path(@profile)
    end
    @newsfeeds = current_user.newsfeeds.order("id DESC")
    @secondary_scope = 'profiles'
  end

end
