class GroupsController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  private
  def resolve_layout
    case action_name
    when "index", "wall"
      "groups_index"
    when "show"
      "groups_show"
    when "new", "edit"
      "form"
    else
      "application"
    end
  end
  
  public
  # GET /groups
  # GET /groups.json

  def index
    if params[:sort] == "latest"
      sort = "created_at DESC"
    elsif params[:sort] == "founded"
      sort = "founded_at DESC"
    else
      sort = "created_at DESC"
    end

    if params[:filter] == "category"
      @groups = Category.find(params[:id]).groups.order(sort)
    elsif params[:filter] == "join"
      @groups = current_user.join_groups.order(sort)
    elsif params[:filter] == "like"
      @groups = current_user.like_groups.order(sort)
    else
      @groups = Group.where(:status => Constant::Approved).order(sort)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @more = @group.activities.count > 3
    @core = @group.comments.recent.count > 8
    @members = @group.admins + @group.members.order("user_groups.updated_at DESC").first(14)
    @mere = @group.members.count > 14

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    authorize! :admin, :site
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @form = true
    @group = Group.find(params[:id])
    authorize! :admin, @group

    case params[:q]
    when '1'
      render :action => :edit_introduction
    when '2'
      render :edit_description
    when '3'
      render :edit_history
    when '4'
      render :edit_organization
    when '5'
      redirect_to @group
    else
      render :edit
    end
  end

  # POST /groups
  # POST /groups.json
  
  def create
    authorize! :admin, :site

    @group = Group.new(params[:group])
    @group.status = Constant::Approving

    respond_to do |format|
      if @group.save
        UserGroup.create(:user => current_user, :group => @group, :status => Constant::Admin + Constant::Approved)
        format.html { redirect_to :action => 'edit', :id => @group.id, :q => 1 }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new", layout: "form" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])
    authorize! :admin, @group

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { 
          if params[:q].nil?
            redirect_to @group
          else
            redirect_to :action => 'edit', :id => @group.id, :q => params[:q]
          end
        }
        format.json { head :ok }
        format.js   { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    authorize! :admin, :site

    @group = Group.find(params[:id]) 
    @group.destroy 
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
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
    ug = UserGroup.f(params[:id], current_user.id)
    
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


  def description
    @group = Group.find(params[:id])
  end

  def history
    @group = Group.find(params[:id])
  end

  def organization
    @group = Group.find(params[:id])
  end

  def activities
    @navi = "activities/navi"
    @group = Group.find(params[:id])
    @activities = @group.activities
  end

  def comments
    @group = Group.find(params[:id])
    @comments = @group.comments.recent
  end

  def members
    @group = Group.find(params[:id])
    @members = @group.members.order("updated_at DESC")
  end

  def wall
    @groups = Group.all
  end
end
