class SearchController < ApplicationController
  before_filter :authenticate_user!
  layout "groups_index"

  def index
    @results = ThinkingSphinx.search params[:q]
    @q = params[:q]
  end

end
