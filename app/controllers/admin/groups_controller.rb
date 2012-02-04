class Admin::GroupsController < ApplicationController
  def index
    @approving_groups = Group.find_all_by_status(Constant::Approving)
    @blocked_groups   = Group.find_all_by_status(Constant::Blocked)
    @approved_groups  = Group.find_all_by_status(Constant::Approved)
  end

  def edit
    pre_approving_list = params[:approving_group]
    pre_blocked_list   = params[:blocked_group]
    pre_approved_list  = params[:approved_group]
    pre_approving_list && pre_approving_list.each do |key, value|
      group = Group.find(key)
      case value.to_i
        when Constant::Approving
        when Constant::Blocked
          group.status &= ~Constant::Approving
          group.status |=  Constant::Blocked
        when Constant::Approved
          group.status &= ~Constant::Approving
          group.status |=  Constant::Approved
        when Constant::Destroy
          group.destroy
      end
    end
    pre_blocked_list && pre_blocked_list.each do |key, value|
      group = Group.find(key)
      case value.to_i
        when Constant::Blocked
        when Constant::Approved
          group.status &= ~Constant::Blocked
          group.status |=  Constant::Approved
        when Constant::Destroy
          group.destroy
      end
    end
    pre_approved_list && pre_approved_list.each do |key, value|
      group = Group.find(key)
      case value.to_i
        when Constant::Approved
        when Constant::Blocked
          group.status &= ~Constant::Approved
          group.status |=  Constant::Blocked
        when Constant::Destroy
          group.destroy
      end
    end

    redirect_to admin_groups_index_path
  end

  def members
    @group = Group.find(params[:id])
    @tenders = @group.tenders
    @members = @group.members
  end

  def forms
    @group = Group.find(params[:id])
    @second_buildings = @group.second_building_applications
  end

end
