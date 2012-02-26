class AdminController < ApplicationController
  before_filter :authenticate_user!
  layout "form"

  def index
    authorize! :admin, :site
  end

end
