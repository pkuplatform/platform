class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @my_activities = @user.activities.limit(5)

  end

end
