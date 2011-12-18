class Admin::FormsController < ApplicationController
  def index
    @second_buildings = Form::SecondBuildingApplication.all
  end

  def edit
    f  = params[:form]
    id = params[:form_id]
    case f
      when "second_building"
        form = Form::SecondBuildingApplication.find(id)
        jwzh = params[:jwzh]
        zhdzhx = params[:zhdzhx]
        form.jiaowuzhang = jwzh
        form.zhidaozhongxin = zhdzhx
    end
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
