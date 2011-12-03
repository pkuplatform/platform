class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to current_user
  end

  def show
    if current_user.profile.nil?
      redirect_to new_profile_path
    end
    @user = User.find(params[:id])
    @q = Group.search(params[:q])
    @my_activities = @user.activities
    @like_users = @user.users_i_like
    @like_activities = @user.activities
    @like_groups = @user.like_groups
    @like_activities = @user.like_activities
    @ranks = RankList.all
  end

  def edit
    @user = User.find(params[:id])
  end

end
