class Admin::GroupsController < ApplicationController
  def index
    @approving_groups = Group.find_by_status(Constant::Approving)
    @blocked_groups   = Group.find_by_status(Constant::Blocked)
    @approved_groups  = Group.find_by_status(Constant::Approved)
  end

  def edit
    group_list = params[:group]
    group_list && group_list.each do |key, value|
      group = Group.find(key)
      case value.to_i
        when Constant::Approving
        when Constant::Approved
          group.status &= ~Constant::Approving
          group.status &= ~Constant::Blocked
          group.status |=  Constant::Approved
        when Constant::Blocked
          group.status &= ~Constant::Approving
          group.status &= ~Constant::Approved
          group.status |=  Constant::Blocked
        when Constant::Destroy
          group.destroy
      end
    end

    redirect_to admin_groups_index_path
  end

end
