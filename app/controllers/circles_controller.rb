class CirclesController < ApplicationController
  # GET /circles
  # GET /circles.json
  helper_method :owner, :circle_path, :circle_url, :circles_path, :circles_url
  helper_method :edit_circle_path, :edit_circle_url, :new_circle_path, :new_circle_url
  layout "groups_show"
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
      root_path+"circles"
    end
  end

  def circles_url
    circles_path
  end


  def circle_path(circle)
    if circle.owner.is_a?(Group)
      group_circle_path(circle.owner,circle)
    elsif circle.owner.is_a?(Activity)
      activity_circle_path(circle.owner,circle)
    else
      root_path+"circles/#{circle.id}"
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
      root_path+"circles/#{circle.id}/edit"
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
      root_path+"circles/new"
    end
  end

  def new_circle_url
    new_circle_path
  end

  def index
    @circles_all = owner.circles.readable(current_user)
    @circles = @circles_all
    @new_circle = Circle.new
    if params[:cnamef]
      @circles = @circles_all.select{|c|params[:cnamef].split(',').include?(c.id.to_s)}
      if @circles.empty?
        @circles = @circles_all
        @all = true
      end
    else
      @all = true
    end
    @users = @circles.first.users
    @circles.each do |circle|
      if params[:cwayf]=='int'
        @users &= circle.users
        @int = true
      else
        @users |= circle.users
      end
    end
    puts @circles
    if can? :admin, owner
      @writable_circles = Hash[*(@circles_all.writable(current_user).collect{|c|[c.id,true]}.flatten)]
      respond_to do |format|
        format.html { render 'users'} # index.html.erb
        format.json { render json: @circles }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: @circles }
      end
    end
  end

  # GET /circles/1
  # GET /circles/1.json
  def show
    @circle = owner.circles.find(params[:id])
    @circles = owner.circles.readable(current_user)
    @writable_circles = Hash[*(@circles.writable(current_user).collect{|c|[c.id,true]}.flatten)]
    unless can? :read, @circle
      redirect_to owner, :alert=> t("circles.unreadable",:owner=>owner.name,:name=>@circle.name)
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @circle }
    end
  end

  def update_user
    @user = User.find(params[:user_id])
    @circles = owner.circles
    @writable_circles = []
    @writable_circles = @circles.writable(current_user)
    @update_circles = []
    @update_circles = @circles.find(params[:circles]).writable(current_user) unless params[:circles].nil?
    if @update_circles == @user.belonged_circles & @writable_circles 
      render :inline=>""
      return
    end
    @removed_circles = @writable_circles - @update_circles
    @update_circles.each do |c|
      uc = UserCircle.find_by_circle_id_and_user_id(c.id,@user.id)
      UserCircle.create(:circle_id=>c.id,:user_id=>@user.id) if uc.nil?
    end
    @ok = true
    @removed_circles.each do |c|
      uc = UserCircle.find_by_circle_id_and_user_id(c.id,@user.id)
      @ok = uc.destroy if uc && @removed_circles.include?(c)
    end
    respond_to do |format|
      format.js
    end
  end


  # GET /circles/new
  # GET /circles/new.json
  def new
    @circle = owner.circles.new
    unless can? :admin, owner
      redirect_to owner, :alert=> t("circles.uncreatable",:owner=>owner.name)
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
    @users = owner.members.collect{|p| ["#{ApplicationController.helpers.image_tag(p.thumb)}<p>#{p.name}</p>",p.id] }

    unless can? :write, @circle
      redirect_to owner, :alert=> t("circles.unwritable",:owner=>owner.name,:name=>@circle.name)
      return
    end
  end

  # POST /circles
  # POST /circles.json
  def create
    @circle = owner.circles.new(params[:circle])
    @circle.name = params[:name]
    unless can? :admin, owner
      redirect_to owner, :alert=> t("circles.uncreatable",:owner=>owner.name)
      return
    end
    respond_to do |format|
      if @circle.save
        format.html { redirect_to @circle, notice: 'circles.create.successfully' }
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
      redirect_to owner, :alert=> t("circles.unwritable",:owner=>owner.name,:name=>@circle.name)
      return
    end
    @update_users = []
    @update_users = User.find(params[:users]) unless params[:users].nil?
    @delete_users = []
    @delete_users = @circle.users - @update_users unless @update_users.nil?
    @circle.user_circles.each do |uc|
      uc.destroy if @delete_users.include?(uc.user)
    end
    @circle.users |= @update_users

    respond_to do |format|
      if @circle.save
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
      redirect_to owner, :alert=> t("circles.undeletable",:owner=>owner.name,:name=>@circle.name)
      return
    end
    @circle.destroy

    respond_to do |format|
      format.html { redirect_to circles_url }
      format.json { head :ok }
    end
  end


  def message
    @circle = Circle.find(params[:id])
    @profiles = @circle.users.shift(20).collect{|p| {:id => p.id,:name=>p.name}}
    unless can? :read, @circle
      redirect_to @circle.owner, :alert=> t("circles.unreadable",:owner=>@circle.owner.name,:name=>@circle.name)
      return
    end
    respond_to do |format|
      format.html 
      format.json { head :ok }
    end
  end

  def change_boss
    unless can? :write, owner.admin_circle
      redirect_to owner, :alert=> t("circles.unwritable",:owner=>@circle.owner.name,:name=>owner.admin_circle.name)
    end
    owner.boss = owner.admins.find(params[:id])
    owner.save
    respond_to do |format|
      format.html { redirect_to owner, :notice=> t("circles.change_boss.successfully",:owner=>owner.name) }
      format.json { head :ok }
    end
  end
end
