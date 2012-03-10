class Admin::GroupsController < ApplicationController
  layout :resolve_layout

  private
  def resolve_layout
    case action_name
    when "index"
      "admin"
    else
      "groups_show"
    end
  end

  public
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
      @groups = Group.unscoped.paginate(:page => params[:page], :per_page => 15)
    else
      @groups = Group.unscoped.where(:status => filter).paginate(:page => params[:page], :per_page => 15)
    end
  end

  def members
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group

    @tenders = @group.tenders
    @admins  = @group.admins
    @members = @group.members
  end

  def forms
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group

    @second_buildings = @group.second_building_applications
  end

  def edit_members
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group

    member = params[:member_id]
    relation = UserGroup.unscoped.f(params[:id], member)
    relation.set(params[:status][member])
    render :nothing => true
  end

  def description
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group
  end

  def introduction
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group
  end

  def history
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group
  end

  def organization
    @group = Group.unscoped.find(params[:id])
    authorize! :admin, @group
  end
end
