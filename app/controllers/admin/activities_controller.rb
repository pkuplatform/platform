class Admin::ActivitiesController < ApplicationController
  layout "admin"

  def index
    authorize! :admin, :backend

    if params[:filter] == "approving"
      filter = Constant::Approving
    elsif params[:filter] == "approved"
      filter = Constant::Approved
    elsif params[:filter] == "blocked"
      filter = Constant::Blocked
    elsif params[:filter] == "rejected"
      filter = Constant::Rejected
    else
      filter = nil 
    end

    if filter.nil?
      @activities = Activity.unscoped.paginate(:page => params[:page], :per_page => 15)
    else
      @activities = Activity.unscoped.where(:status => filter).paginate(:page => params[:page], :per_page => 15)
    end
  end

end
