class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.first(50)
    @daily_ranks = Activity.daily_ranks
    @weekly_ranks = Activity.weekly_ranks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end


  def picture
    @picture = Picture.find(params[:pic_id])
  end
  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])
    @group = @activity.group
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
    @activity = Group.find(params[:id]).activities.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  def comment
    @activity = Activity.find(params[:id])
    @comment = @activity.comments.create(:user=>current_user,:body=>params["comment-content"])
 
    respond_to do |format|
      format.js
    end
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        UserActivity.create(:user => current_user, :activity => @activity, :status => (1 << 8))
        Event.create(:subject_type => "group", :subject_id => params[:activity][:group_id], :action => "create", :object_type => "activity", :object_id => @activity.id, :processed => false)
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

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :ok }
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
      if ua
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
    @tenders = @activity.tenders
    @members = @activity.members
  end

  def edit_members
    @activity = Activity.find(params[:id])

    member_list = params[:member]
    member_list && member_list.each do |key, value|
      ua = UserActivity.find_by_activity_id_and_user_id(@activity, key)
      case value.to_i
        when Constant::Approving
        when Constant::Member
          ua.status |= ~Constant::Approving
          ua.status |= ~Constant::Rejected
          ua.status &=  Constant::Member
        when Constant::Rejected
          ua.status |= ~Constant::Approving
          ua.status |= ~Constant::Member
          ua.status &=  Constant::Rejected
      end
      ua.save
    end
      
    redirect_to show_members_activity_path
  end
end
