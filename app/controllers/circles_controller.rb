class CirclesController < ApplicationController

  helper_method :owner, :circle_path, :circle_url, :circles_path, :circles_url
  helper_method :edit_circle_path, :edit_circle_url, :new_circle_path, :new_circle_url
  layout :resolve_layout

  before_filter :build_owner

  private
  def resolve_layout
    if owner.is_a?(Group)
      "groups_show"
    elsif owner.is_a?(Activity)
      "activities_show"
    else
      "profile"
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

  def build_owner
    @owner = owner
    if owner.is_a?(Group)
      @group = owner
    elsif owner.is_a?(Activity)
      @activity = owner
      @group = @activity.group
    else
      @user = owner
    end
  end

public


  def circles_path(params={})
    if owner.is_a?(Group)
      group_circles_path(owner,params)
    elsif owner.is_a?(Activity)
      activity_circles_path(owner,params)
    else
      root_path+"circles"
    end
  end

  def circles_url
    circles_path
  end


  def circle_path(circle,params={})
    if circle.owner.is_a?(Group)
      group_circle_path(circle.owner,circle,params)
    elsif circle.owner.is_a?(Activity)
      activity_circle_path(circle.owner,circle,params)
    else
      root_path+"circles/#{circle.id}"
    end
  end


  def circle_url(circle)
    circle_path(circle)
  end


  def index
    @circles = @owner.circles.readable(current_user)
    @circle = @owner.member_circle
    @new_circle= Circle.new
  end

  def show
    @circles = @owner.circles.readable(current_user)
    @circle = @owner.circles.find(params[:id])
    @new_circle= Circle.new
    authorize! :read, @circle
    @applicant = (@circle.status == Constant::Approving) && (can? :admin, @owner)
    @member = (@circle.status == Constant::Member) && (can? :admin, @owner)

  end

  def update_user
    @user = User.find(params[:user_id])
    @circles = @owner.circles
    @selectable_circles = []
    @selectable_circles = @circles.selectable(current_user)
    @update_circles = []
    @update_circles = @circles.find(params[:circles]).selectable(current_user) unless params[:circles].nil?
    if @update_circles == @user.belonged_circles & @selectable_circles 
      render :inline=>""
      return
    end
    @removed_circles = @selectable_circles - @update_circles


    if @removed_circles.include?(@owner.admin_circle) && @user==@owner.boss 
      @reason = "circles.cannot_remove_boss"
    else
      @update_circles.each do |c|
        uc = UserCircle.find_by_circle_id_and_user_id(c.id,@user.id)
        UserCircle.create(:circle_id=>c.id,:user_id=>@user.id) if uc.nil?
      end
      @ok = true
      @removed_circles.each do |c|
        uc = UserCircle.find_by_circle_id_and_user_id(c.id,@user.id)
        @ok = uc.destroy if uc && @removed_circles.include?(c)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  # GET /circles/1/edit
  def edit
    @circle = @owner.circles.find(params[:id])
    @users = @owner.members.collect{|p| ["#{ApplicationController.helpers.image_tag(p.thumb)}<p>#{p.name}</p>",p.id] }

    unless can? :write, @circle
      redirect_to owner, :alert=> t("circles.unwritable",:owner=>owner.name,:name=>@circle.name)
      return
    end
  end

  # POST /circles
  # POST /circles.json
  def create
    @circle = @owner.circles.new(params[:circle])
    unless can? :admin, @owner
      redirect_to @owner, :alert=> t("circles.uncreatable",:owner=>@owner.name)
      return
    end
    respond_to do |format|
      if @circle.save
        format.html { redirect_to @circle, notice: 'circles.create.successfully' }
        format.json { render json: @circle, status: :created, location: @circle }
      else
        format.html { render inline: "new" }
        format.json { render json: @circle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /circles/1
  # PUT /circles/1.json
  def update
    @circle = @owner.circles.find(params[:id])

    respond_to do |format|
      if @circle.update_attributes(params[:circle])
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
    @circle = @owner.circles.find(params[:id])
    unless can? :delete, @circle
      redirect_to @owner, :alert=> t("circles.undeletable",:owner=>@owner.name,:name=>@circle.name)
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
    @profiles = @circle.users.collect{|p| {:id => p.id,:name=>p.name}}
    unless can? :read, @circle
      redirect_to @circle.owner, :alert=> t("circles.unreadable",:owner=>@circle.owner.name,:name=>@circle.name)
      return
    end
    respond_to do |format|
      format.html { render 'mailboxes/new'}
      format.json { head :ok }
    end
  end

  def change_boss
    unless can? :write, @owner.admin_circle
      redirect_to @owner, :alert=> t("circles.unwritable",:owner=>@owner.name,:name=>@owner.admin_circle.name)
    end
    @owner.boss = @owner.admins.find(params[:user_id])
    @owner.save
    respond_to do |format|
      format.html { redirect_to circle_path(@owner.admin_circle), :notice=> t("circles.change_boss.successfully",:owner=>@owner.name) }
      format.json { head :ok }
    end
  end

  def approve
    authorize! :admin, @owner
    @user=User.find(params[:user_id])
    respond_to do |format|
      if @owner.applicants.include?(@user)
        @owner.member_circle.add(@user)
        @owner.applicant_circle.remove(@user)
        @ok = true
      else
        @reason = t("circles.not_applicant")
      end
      format.js 
    end
  end

  def reject
    authorize! :admin, @owner
    @user=User.find(params[:user_id])
    respond_to do |format|
      if @owner.applicants.include?(@user)
        @owner.applicant_circle.remove(@user)
        @ok = true
      else
        @reason = t("circles.not_applicant")
      end
      format.js 
    end
  end

  def kickout
    authorize! :admin, @owner
    @user=User.find(params[:user_id])
    respond_to do |format|
      if @owner.admins.include?(@user)
        @reason = t("circles.cannot_kickout_admin")
      elsif @owner.members.include?(@user)
        @ok = true
        @owner.member_circle.remove(@user)
        @owner.circles.each{|c| c.remove(@user) if c.users.include?(@user)}
      else
        @reason = t("circles.not_member")
      end
      format.js 
    end
  end
end
