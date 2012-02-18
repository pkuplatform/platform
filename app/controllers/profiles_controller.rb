class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout

  private
  def resolve_layout
    case action_name
    when "new", "edit"
      "form"
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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  def index
    qs = "%"
    Hz2py.do(params[:q]).each_char{|c| qs+= c + '%'}
    @profiles = Profile.select("id,name").where("pyname like ?",qs).limit(20)
    @nameids = @profiles.collect {|p| "#{p.name}(#{p.id})" }
    respond_to do |format|
      format.json { render json: @nameids }
      format.html
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
    @user = @profile.user
    if current_user!=@user 
      redirect_to @user, :notice => "You are not allowed to edit others' profile!"
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])
    @profile.user = current_user

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
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :ok }
    end
  end

  def like
    @profile = Profile.find(params[:id])
    ur = UserRelation.find_by_liking_id_and_liked_id(current_user.id, @profile.user.id)
    if ur.nil?
      UserRelation.create!(:liking_id => current_user.id, :liked_id => @profile.user.id)
    else
      ur.destroy
    end
    redirect_to @profile
  end
end
