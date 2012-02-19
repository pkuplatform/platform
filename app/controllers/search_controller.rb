class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = Group.search(params[:q])
    @activities = Activity.search(params[:q])
    @profiles = Profile.search(params[:q])
    @q = params[:q]
  end

end
