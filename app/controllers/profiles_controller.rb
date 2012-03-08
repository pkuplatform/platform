class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout
  impressionist :actions => [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  private
  def resolve_layout
    case action_name
    when "new", "edit"
      "form"
    when "show", "users"
      "profile"
    else
      "application"
    end
  end
  
  public
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @groups = @profile.user.groups
    @activities = @profile.user.activities
    @friends = @profile.user.friends
    @follows = @profile.user.follows - @friends
    @fans = @profile.user.fans - @friends

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  def index
    qs = "%"
    Hz2py.do(params[:q]).each_char{|c| qs+= c + '%'}
    @profiles = Profile.where("lower(pyname) like ?",qs.downcase).limit(100)
    @profiles.keep_if{|p| current_user.related_users.include?(p.user)}
    qs = qs.gsub('%','#')
    @profiles = @profiles.sort! { |x,y| x.pyname.score(qs)<=>y.pyname.score(qs) }
    @hashed = @profiles.shift(20).collect {|p| {:label=>"#{ApplicationController.helpers.image_tag(p.thumb)}<p>#{p.name}</p>", :value=>"#{p.name}(#{p.id})" } }
    respond_to do |format|
      format.json { render json: @hashed }
    end
  end

  def token
    qs = "%"
    Hz2py.do(params[:q]).each_char{|c| qs+= c + '%'}
    @profiles = Profile.where("lower(pyname) like ?",qs.downcase).limit(100)
    @profiles.keep_if{|p| current_user.related_users.include?(p.user)}
    qs = qs.gsub('%','#')
    @profiles = @profiles.sort! { |x,y| x.pyname.score(qs)<=>y.pyname.score(qs) }
    @profiles = @profiles.shift(20).collect{|p| {:id => p.id, :avatar=>ApplicationController.helpers.image_tag(p.thumb),:search_name=>p.name+"(#{p.pyname})",:name=>p.name}}
    respond_to do |format|
      format.json { render json: @profiles }
      format.html { render :nothing => true }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    authorize! :edit, @profile
    @user = @profile.user
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to current_user, notice: 'Profile was successfully created.' }
        format.json { render json: profile_user_path, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])
    authorize! :edit, @profile
    @user = @profile.user

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to profile_path(@profile), notice: 'Profile was successfully updated.' }
        format.json { head :ok }
        format.js   { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    authorize! :admin, :site
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :ok }
    end
  end


  def like
    @profile = Profile.find(params[:id])
    authorize! :like, @profile

    @profile.user.fan_circle.add(current_user)
    redirect_to @profile
  end

  def unlike
    @profile = Profile.find(params[:id])
    authorize! :unlike, @profile

    @profile.user.fan_circle.remove(current_user)
    redirect_to @profile
  end

  def users
    @profile = Profile.find(params[:id])
    @friends = @profile.user.friends
    @follows = @profile.user.follows - @friends
    @fans = @profile.user.fans - @friends
  end
end
