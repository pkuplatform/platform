class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  private
  def resolve_layout
    case action_name
    when "index", "wall"
      "activities_index"
    when "show"
      "activities_show"
    when "new", "edit"
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

    @activities = []
    if params[:filter] == "category"
      Category.find(params[:id]).groups.each do |group|
        @activities += group.activities
      end
    elsif params[:filter] == "join"
      @activities = current_user.join_activities.order(sort)
    elsif params[:filter] == "like"
      @activities = current_user.like_activities.order(sort)
    else
      @activities = Activity.order(sort).limit(50)
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

    respond_to do |format|
      if @activity.save
        UserActivity.create(:user => current_user, :activity => @activity, :status => Constant::Admin + Constant::Member)
        Event.create(:subject_type => "Group", :subject_id => params[:activity][:group_id], :action => "create", :object_type => "Activity", :object_id => @activity.id, :processed => false)
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
    ua = @activity.user_activities.find_by_user_id(current_user)
    
    if @activity.followers.include?(current_user)
      ua.status &= ~Constant::Like
      ua.save
    else
      if ua
        ua.status |= Constant::Like
        ua.save
      else
        UserActivity.create!(:activity_id => @activity.id, :user_id => current_user.id, :status => Constant::Like)
        Event.create(:subject_type=>"User",:subject_id=>current_user.id,:action=>:like,:object_type=>"Activity",:object_id=>@activity.id)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def join
    @activity = Activity.find(params[:id])
    ua = @activity.user_activities.find_by_user_id(current_user)
    
    if @activity.members.include?(current_user)
      ua.status &= ~Constant::Member
      ua.save
    else
      if @activity.public?
        if ua
          ua.status |= Constant::Member
          ua.save
        else
          UserActivity.create!(:activity_id => @activity.id, :user_id => current_user.id, :status => Constant::Member)
        end
        Event.create(:subject_type=>"User",:subject_id => current_user.id, :action=>:join, :object_type=>"Activity", :object_id => @activity.id)
      elsif ua
        ua.status |= Constant::Approving
        ua.save
      else
        UserActivity.create!(:activity_id => @activity.id, :user_id => current_user.id, :status => Constant::Approving)
      end

    end
    respond_to do |format|
      format.js
    end
  end

  def show_members
    @activity = Activity.find(params[:id])
    @group = @activity.group
    @tenders = @activity.tenders
    @members = @activity.members
  end

  def tag_cloud
    @tags = Activity.tag_counts
  end

  def tag
    if params[:sort] == "latest"
      sort = "created_at DESC"
    elsif params[:sort] == "pop"
      sort = "points DESC"
    else
      sort = "created_at DESC"
    end

    @activities = []
    if params[:filter] == "category"
      Category.find(params[:id]).groups.each do |group|
        @activities += group.activities
      end
    elsif params[:filter] == "join"
      @activities = current_user.join_activities.order(sort)
    elsif params[:filter] == "like"
      @activities = current_user.like_activities.order(sort)
    else
      @activities = Activity.order(sort).limit(50)
    end

    @tag = ActsAsTaggableOn::Tag.find_by_name(params[:tag_name])
    @activities = @activities.find_all {|a| a.tags.include?(@tag)}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end  
  end

  def wall
    @activities = Activity.first(50)
  end
end
