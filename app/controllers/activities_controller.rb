class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  private
  def resolve_layout
    case action_name
    when "index", "wall"
      "activities_index"
    when "show", "edit"
      "activities_show"
    when "new"
      "form"
    else
      "application"
    end
  end

  public
  #layout 'activities'
  # GET /activities
  # GET /activities.json
  def index

    @hots = Activity.first(5)

    if params[:sort] == "latest"
      sort = "created_at DESC"
    elsif params[:sort] == "pop"
      sort = "points DESC"
    else
      sort = "created_at DESC"
    end

    if params[:tags]
      @activities = Activity.tagged_with(params[:tags])
      @tags = params[:tags].split(',').map(&:strip).reject(&:blank?).map{ |e| {:name => e} }
    else
      @activities = Activity
    end
    
    if params[:filter] == "category"
      @activities = @activities.category(Category.find(params[:id])).order(sort)
    elsif params[:filter] == "join"
      @activities = @activities.order(sort).joined(current_user)
    elsif params[:filter] == "like"
      @activities = @activities.order(sort).liked(current_user)
    else
      @activities = @activities.order(sort).limit(50)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end


  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])
    @group = @activity.group
    @bore = @activity.blogs.count > 4
    @pore = @activity.pictures.count > 6
    @core = @activity.comments.recent.count > 6
    if @activity.admins.include?(current_user)
      @is_admin = true
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @group = Group.find(params[:group_id])
    authorize! :admin, @group

    @activity = @group.activities.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @group = Group.find(params[:group_id])
    @activity = Activity.find(params[:id])
    authorize! :admin, @activity
  end

  # POST /activities
  # POST /activities.json
  def create
    @group = Group.find(params[:activity][:group_id])
    authorize! :admin, @group

    @activity = Activity.new(params[:activity])
    @activity.status = Constant::Approving
    @activity.boss = current_user

    respond_to do |format|
      if @activity.save
        @activity.admin_circle.add(current_user)
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])
    authorize! :admin, @activity

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated' }
        format.json { head :ok }
        format.js { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    authorize! :admin, @activity

    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :ok }
    end
  end

  def like
    @activity = Activity.find(params[:id])
    authorize! :like, @activity

    @activity.fan_circle.add(current_user)
    head :ok
  end

  def unlike
    @activity = Activity.find(params[:id])
    authorize! :unlike, @activity

    @activity.fan_circle.remove(current_user)
    head :ok
  end

  def join
    @activity = Activity.find(params[:id])
    authorize! :join, @activity

    if @activity.public
      @activity.member_circle.add(current_user)
    else
      @activity.applicant_circle.add(current_user)
    end

    respond_to do |format|
      format.js
    end
  end

  def exit
    @activity = Activity.find(params[:id])
    authorize! :exit, @activity

    @activity.member_circle.remove(current_user)
    respond_to do |format|
      format.js { render 'join' }
    end
  end

  def tag_cloud
    @tags = Activity.tag_counts
  end

  def wall
    @activities = Activity.first(50)
  end
end
