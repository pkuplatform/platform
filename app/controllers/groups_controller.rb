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
    
    if @group.followers.include?(current_user)
      ug.status &= ~Constant::Like
      ug.save
    else
      if ug
        ug.status |= Constant::Like
        ug.save
      else
        UserGroup.create!(:group_id => @group, :user_id => current_user, :status => Constant::Like)
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
        ug.status |= Constant::Member
        ug.save
      else
        UserGroup.create!(:group_id => @group, :user_id => current_user, :status => Constant::Member)
      end
    end
    respond_to do |format|
      format.js
    end
  end
end
