class SearchController < ApplicationController
  def index
    @q = params[:q]
    unless @q.blank?
      @results = Group.search @q
    end
  end

end
