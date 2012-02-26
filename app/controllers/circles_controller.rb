class CirclesController < ApplicationController
  # GET /circles
  # GET /circles.json
  helper_method :owner, :circle_path, :edit_circle_path, :edit_circle_url, :new_circle_path, :new_circle_url
  layout "form"

  def owner
    if params[:group_id]
      Group.find(params[:group_id])
    elsif params[:activity_id]
      Activity.find(params[:activity_id])
    else
      current_user
    end
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

    @circles = owner.circles
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @circles }
    end
  end

  # GET /circles/1
  # GET /circles/1.json
  def show
    @circle = owner.circles.find(params[:id])

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
    @users = owner.users
    @circles = owner.circles.keep_if{|c| can? :write,c}
  end

  def update_user
    @user = User.find(params[:user_id])
    @writable_circles = owner.circles.keep_if{|c| can? :write,c}
    @user.belonged_circles -= @writable_circles
    @user.belonged_circles |= @writable_circles.find(params[:circles] unless params[:circles].nil?
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
