class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @my_activities = @user.activities
    @like_groups = @user.like_groups
    @like_activities = @user.like_activities
  end

  def edit
    @user = User.find(params[:id])
  end

end
