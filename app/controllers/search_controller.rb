class SearchController < ApplicationController
  before_filter :authenticate_user!
  layout "groups_index"

  def index
    @groups = Group.search(params[:q])
    @activities = Activity.search(params[:q])
    @profiles = Profile.search(params[:q])
    
    @empty = @groups.blank? and @activities.blank? and @profiles.blank?
    @q = params[:q]
  end

end
