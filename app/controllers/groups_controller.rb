class GroupsController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  private
  def resolve_layout
    case action_name
    when "index", "wall"
      "groups_index"
    when "new", "create"
      "admin"
    else
      "groups_show"
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
      @groups = Group.category(Category.find(params[:id])).order(sort)
    elsif params[:filter] == "join"
      @groups = Group.order(sort).joined(current_user)
    elsif params[:filter] == "like"
      @groups = Group.order(sort).liked(current_user)
    else
      @groups = Group.order(sort).all
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
    @members = @group.members
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
    @group.boss_id = current_user.id

    respond_to do |format|
      if @group.save
        @group.admin_circle.add(current_user)
        @group.member_circle.add(current_user)
        format.html { redirect_to :action => 'edit', :id => @group.id, :q => 1 }
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
    authorize! :like, @group

    @group.fan_circle.add(current_user)
  end

  def unlike
    @group = Group.find(params[:id])
    authorize! :unlike, @group

    @group.fan_circle.remove(current_user)
  end

  def join
    @group = Group.find(params[:id])
    authorize! :join, @group

    @group.applicant_circle.add(current_user)
  end

  def exit
    @group = Group.find(params[:id])
    authorize! :exit, @group

    @group.member_circle.remove(current_user)
    render :join
  end

  def description
    @group = Group.find(params[:id])
    @crumbs.push({:name=>@group.name, :path=>group_path(@group)})
    @crumbs.push({:name=>"groups.description.header", :path=>description_group_path(@group)})

  end

  def history
    @group = Group.find(params[:id])
    @crumbs.push({:name=>@group.name, :path=>group_path(@group)})
    @crumbs.push({:name=>"groups.history.header", :path=>organization_group_path(@group)})

  end

  def organization
    @group = Group.find(params[:id])
    @crumbs.push({:name=>@group.name, :path=>group_path(@group)})
    @crumbs.push({:name=>"groups.organization.header", :path=>organization_group_path(@group)})

  end

  def activities
    @navi = "activities/navi"
    @group = Group.find(params[:id])
    @activities = @group.activities
    @crumbs.push({:name=>@group.name, :path=>group_path(@group)})
    @crumbs.push({:name=>"groups.activities.title", :path=>group_activities_path(@group)})
  end

  def comments
    @group = Group.find(params[:id])
    @comments = @group.comments.recent
  end

  def wall
    @groups = Group.all
  end
end
