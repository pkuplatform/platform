class Admin::GroupsController < ApplicationController
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
    @members = @group.members
  end

  def forms
    @group = Group.find(params[:id])
    @second_buildings = @group.second_building_applications
  end

  def edit_members
    @group = Group.find(params[:id])

    pre_tenders_list = params[:pre_tender]
    pre_members_list = params[:pre_member]

    pre_tenders_list && pre_tenders_list.each do |key, value|
      ug = UserGroup.find_by_group_id_and_user_id(@group, key)
      case value.to_i
        when Constant::Approving
        when Constant::Member
          ug.status &= ~Constant::Approving
          ug.status |=  Constant::Member
          Event.create(:subject_type=>"User",:subject_id => key, :action=>:join, :object_type=>"Group", :object_id => @group.id)
        when Constant::Rejected
          ug.status &= ~Constant::Approving
          ug.status |=  Constant::Rejected
      end
      ug.save
    end
    pre_members_list && pre_members_list.each do |key, value|
      ug = UserGroup.find_by_group_id_and_user_id(@group, key)
      case value.to_i
        when Constant::Member
        when Constant::Rejected
          ug.status &= ~Constant::Member
          ug.status |=  Constant::Rejected
      end
      ug.save
    end
      
    redirect_to members_admin_group_path
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
