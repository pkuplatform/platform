class Admin::GroupsController < ApplicationController
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
      @groups = Group.page(params[:page])
    else
      @groups = Group.where(:status => filter).page(params[:page])
    end
  end

  def members
    @group = Group.find(params[:id])
    @tenders = @group.tenders
    @admins  = @group.admins
    @members = @group.members
  end

  def forms
    @group = Group.find(params[:id])
    @second_buildings = @group.second_building_applications
  end

  def edit_members
    member = params[:member_id]
    relation = UserGroup.f(params[:id], member)
    relation.set(params[:status][member])
    render :nothing => true
  end

  def description
    @group = Group.find(params[:id])
  end

  def introduction
    @group = Group.find(params[:id])
  end

  def history
    @group = Group.find(params[:id])
  end

  def organization
    @group = Group.find(params[:id])
  end
end
