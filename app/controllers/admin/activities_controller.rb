class Admin::ActivitiesController < ApplicationController
  layout "form"

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
      @activities = Activity.paginate(:page => params[:page], :per_page => 10)
    else
      @activities = Activity.where(:status => filter).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def change_group
    @selected_group = Group.find(params[:group][:id])
    @activities = @selected_group.activities
    respond_to do |format|
      format.js
    end
  end

  def edit
    del_list = params[:del]
    del_list && del_list.each do |key, value|
      if value.to_i == 1
        activity = Activity.find(key)
        activity.destroy
      end
    end
    @groups = Group.all
    @selected_group = Group.find(params[:group])
    @activities = @selected_group.activities

    redirect_to admin_activities_index_path
  end

end
