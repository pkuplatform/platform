class Admin::MembersController < ApplicationController
  def index
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
      @profiles = Profile.page(params[:page])
    else
      @profiles = Profile.where(:status => filter).page(params[:page])
    end
  end
end
