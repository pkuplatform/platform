class Admin::FormsController < ApplicationController
  layout "form"
  def index
    authorize! :manage, :all

    if params[:filter] == "approving"
      filter = Constant::Approving
    elsif params[:filter] == "approved"
      filter = Constant::Approved
    elsif params[:filter] == "rejected"
      filter = Constant::Rejected
    else
      filter = nil
    end

    if filter.nil?
      @forms = Form::SecondBuildingApplication.paginate(:page => params[:page], :per_page => 10)
    else
      @forms = Form::SecondBuildingApplication.where(:status => filter).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    authorize! :manage, :all
    @form = Form::SecondBuildingApplication.find(params[:id])
  end
end
