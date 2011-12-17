class Admin::ActivitiesController < ApplicationController

  def index
    @groups = Group.all
    @selected_group = Group.first
    @activities = @selected_group.activities
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
