class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @q = Group.search(params[:q])
    if @user.profile.nil?
      profile = Profile.new
      @user.profile = profile
      profile.save
    end
    @my_activities = @user.activities
    @like_groups = @user.like_groups
    @like_activities = @user.like_activities
  end

  def edit
  end

end
