class Admin::MembersController < ApplicationController
  layout "form"
  def index
    authorize! :manage, :all

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
      @profiles = Profile.paginate(:page => params[:page], :per_page => 10)
    else
      @profiles = Profile.where(:status => filter).paginate(:page => params[:page], :per_page => 10)
    end
  end
end
