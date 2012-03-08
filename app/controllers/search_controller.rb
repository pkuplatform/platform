class SearchController < ApplicationController
  before_filter :authenticate_user!
  layout "profile"

  def index
    @results = Array.new
    # @results = ThinkingSphinx.search params[:q]
    @results = Activity.search(params[:q])
    @q = params[:q]
  end

end
