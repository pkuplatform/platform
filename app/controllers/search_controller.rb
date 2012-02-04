class SearchController < ApplicationController
  def index
    @groups = Group.search(params[:q])
    @activities = Activity.search(params[:q])
    @profiles = Profile.search(params[:q])
  end

end
