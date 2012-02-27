class CirclesController < ApplicationController
  # GET /circles
  # GET /circles.json
  helper_method :owner, :circle_path, :circle_url, :circles_path, :circles_url
  helper_method :edit_circle_path, :edit_circle_url, :new_circle_path, :new_circle_url
  layout "form"
  before_filter :build_owner

  def build_owner
    if owner.is_a?(Group)
      @group = owner
    elsif owner.is_a?(Activity)
      @activity = owner
    else
      @user = owner
    end
  end

  def owner
    if params[:group_id]
      Group.find(params[:group_id])
    elsif params[:activity_id]
      Activity.find(params[:activity_id])
    else
      current_user
    end
  end

  def circles_path
    if owner.is_a?(Group)
      group_circles_path(owner)
    elsif owner.is_a?(Activity)
      activity_circles_path(owner)
    else
      root_path+"/circles"
    end
  end

  def circles_url
    circles_path
  end


  def circle_path(circle)
    owner = circle.owner
    if owner.is_a?(Group)
      group_circle_path(owner,circle)
    elsif owner.is_a?(Activity)
      activity_circle_path(owner,circle)
    else
      root_path+"/circles/#{circle.id}"
    end
  end


  def circle_url(circle)
    circle_path(circle)
  end

  def edit_circle_path(circle)
    owner = circle.owner
    if owner.is_a?(Group)
      edit_group_circle_path(owner,circle)
    elsif owner.is_a?(Activity)
      edit_activity_circle_path(owner,circle)
    else
      root_path+"/circles/#{circle.id}/edit"
    end
  end

  def edit_circle_url(circle)
    edit_circle_path(circle)
  end

  def new_circle_path
    if owner.is_a?(Group)
      new_group_circle_path(owner)
    elsif owner.is_a?(Activity)
      new_activity_circle_path(owner)
    else
      root_path+"/circles/new"
    end
  end

  def new_circle_url
    new_circle_path
  end

  def index

    @circles = owner.circles.readable(current_user)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @circles }
    end
  end

  # GET /circles/1
  # GET /circles/1.json
  def show
    @circle = owner.circles.find(params[:id])
    @circles = owner.circles.readable(current_user)
    @writable_circles = Hash[*(@circles.writable(current_user).collect{|c|[c.id,true]}.flatten)]
    unless can? :read, @circle
      redirect_to owner, :alert=>"no auth"
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @circle }
    end
  end

  def users
    unless can? :admin, owner
      redirect_to owner, :alert=>"no auth"
      return
    end
    @users = owner.persons
    @circles = owner.circles.readable(current_user)
    @writable_circles = Hash[*(@circles.writable(current_user).collect{|c|[c.id,true]}.flatten)]
  end

  def update_user
    @user = User.find(params[:user_id])
    @circles = owner.circles
    @writable_circles = @circles.writable(current_user)
    @update_circles = @circles.find(params[:circles]).writable(current_user) unless params[:circles].nil?
    if @update_circles == @user.belonged_circles & @writable_circles 
      render :inline=>""
      return
    end
    @user.belonged_circles -= @writable_circles
    @user.belonged_circles |= @update_circles
    respond_to do |format|
      if @user.save
        format.js
      else
        format.js :alert=> "something wrong!"
      end
    end
  end


  # GET /circles/new
  # GET /circles/new.json
  def new
    @circle = owner.circles.new
    unless can? :admin, owner
      redirect_to owner, :alert=>"no auth"
      return
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @circle }
    end
  end

  # GET /circles/1/edit
  def edit
    @circle = owner.circles.find(params[:id])
    unless can? :write, @circle
      redirect_to owner, :alert=>"no auth"
      return
    end
  end

  # POST /circles
  # POST /circles.json
  def create
    @circle = owner.circles.new(params[:circle])
    respond_to do |format|
      if @circle.save
        format.html { redirect_to @circle, notice: 'Circle was successfully created.' }
        format.json { render json: @circle, status: :created, location: @circle }
      else
        format.html { render action: "new" }
        format.json { render json: @circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /circles/1
  # PUT /circles/1.json
  def update
    @circle = owner.circles.find(params[:id])
    unless can? :write, @circle
      redirect_to owner, :alert=>"no auth"
      return
    end
    @circle.users = []
    @circle.users = User.find(params[:users]) unless params[:users].nil?

    respond_to do |format|
      if @circle.save&&@circle.update_attributes(params[:circle])
        format.html { redirect_to @circle, notice: 'Circle was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /circles/1
  # DELETE /circles/1.json
  def destroy
    @circle = owner.circles.find(params[:id])
    unless can? :delete, @circle
      redirect_to owner, :alert=>"no auth"
      return
    end
    @circle.destroy

    respond_to do |format|
      format.html { redirect_to circles_url }
      format.json { head :ok }
    end
  end
end
