class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.paginate(:page => params[:page])
    @daily_ranks = Group.daily_ranks
    @weekly_ranks = Group.weekly_ranks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group.status = Constant::Approving

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id]) 
    @group.destroy 
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
  end

  def show_forms
    @group = Group.find(params[:id])
    @second_buildings = @group.second_building_applications
  end

  def like
    @group = Group.find(params[:id])
    ug = @group.user_groups.find_by_user_id(current_user)
    puts "----------0000--------------"
    
    if @group.followers.include?(current_user)
      puts "----------1111--------------"
      ug.status &= ~Constant::Like
      ug.save
    else
      if ug
        puts "----------2222--------------"
        ug.status |= Constant::Like
        ug.save
      else
        puts "----------3333--------------"
        puts "--------#{@group.id}-------"
        puts "--------#{current_user.id}-------"
        UserGroup.create!(:group_id => @group.id, :user_id => current_user.id, :status => Constant::Like)
        Event.create(:subject_type=>"User",:subject_id=>current_user.id,:action=>:like,:object_type=>"Group",:object_id=>@group.id)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def join
    @group = Group.find(params[:id])
    ug = @group.user_groups.find_by_user_id(current_user)
    
    if @group.members.include?(current_user)
      ug.status &= ~Constant::Member
      ug.save
    else
      if ug
        ug.status |= Constant::Approving
        ug.save
      else
        UserGroup.create!(:group_id => @group.id, :user_id => current_user.id, :status => Constant::Approving)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def show_members
    @group = Group.find(params[:id])
    @tenders = @group.tenders
    @members = @group.members
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
      
    redirect_to show_members_group_path
  end

  def show_activities
    @group = Group.find(params[:id])
    @activities = @group.activities
  end

  def edit_activities
    @group = Group.find(params[:id])

    del_list = params[:del]
    del_list && del_list.each do |key, value|
      if value.to_i == 1
        activity = Activity.find(key)
        activity.destroy
      end
    end

    redirect_to show_activities_group_path
  end

end
