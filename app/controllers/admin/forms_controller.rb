class Admin::FormsController < ApplicationController
  def index
    @forms = Form::SecondBuildingApplication.all
  end

  def show
    @form = Form::SecondBuildingApplication.find(params[:id])
  end

  def edit
    @form = Form::SecondBuildingApplication.find(params[:id])
    status = params[:status].first.to_i
    case status
      when Constant::Approving
      when Constant::Approved
        form.status = Constant::Approved
        form.save
      when Constant::Rejected
        form.status = Constant::Rejected
        form.save
      when Constant::Destroy
        form.destroy
    end
    redirect_to admin_forms_index_path
  end

end
