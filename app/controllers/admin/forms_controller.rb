class Admin::FormsController < ApplicationController
  def index
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
      @forms = Form::SecondBuildingApplication.page(params[:page])
    else
      @forms = Form::SecondBuildingApplication.where(:status => filter).page(params[:page])
    end
  end

  def show
    @form = Form::SecondBuildingApplication.find(params[:id])
  end
end
