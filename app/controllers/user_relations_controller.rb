class UserRelationsController < ApplicationController

  def create
    @user = User.find(params[:user_relation][:liked_id])
    current_user.like!(@user)
    redirect_to @user
  end

  def destroy
    @user = UserRelation.find(params[:id]).liked
    current_user.dislike!(@user)
    redirect_to @user
  end
end

