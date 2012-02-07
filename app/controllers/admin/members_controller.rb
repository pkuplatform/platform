class Admin::MembersController < ApplicationController
  def index
    @users = User.all || []
  end

  def edit
    user_list = params[:user]
    user_list && user_list.each do |key, value|
      case value.to_i
        when Constant::Approved
        when Constant::Destroy
          u = User.find(key)
          u.destroy
      end
    end

    redirect_to admin_members_index_path
  end

end
