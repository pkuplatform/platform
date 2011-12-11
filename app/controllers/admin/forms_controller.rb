class Admin::FormsController < ApplicationController
  def index
    @second_buildings = Form::SecondBuildingApplication.all
  end

end
