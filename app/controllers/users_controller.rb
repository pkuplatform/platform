class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to current_user
  end

  def favor
    @type = params[:type]
    puts @type
    @user = User.find(params[:id])
    if @type=='users'
      @favor_list =  @user.users_i_like
    elsif @type=='groups'
      @favor_list =  @user.like_groups
    elsif @type=='activities'
      @favor_list =  @user.like_activities
    else
      @favor_list = @user.users_i_like
    end
  end

  def show
    if current_user.profile.nil?
      @profile=Profile.new
      @profile.user = current_user
      @profile.save
      redirect_to edit_profile_path(@profile)
    end
    @user = User.find(params[:id])
    @q = Group.search(params[:q])
    @my_activities = @user.activities
    @like_users = @user.users_i_like
    @like_activities = @user.activities
    @like_groups = @user.like_groups
    @like_activities = @user.like_activities
    @join_activities = @user.join_activities
    @daily_ranks = User.daily_ranks
    @newsfeeds = @user.newsfeeds.order("id DESC")
    if @user!=current_user
      @profile = @user.profile
      @others_page = true
      render "profiles/show"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

end
