class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    #redirect_to current_user
  end

  def favors
    if params[:class]=='user'
    end
  end

  def show
    if current_user.profile.nil? or current_user.profile.student_id.nil?
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
    @newsfeeds = @user.newsfeeds
    if @user!=current_user
      @profile = @user.profile
      render "profiles/show"
    end
  end

  def edit
    @user = User.find(params[:id])
  end



end
