class Form::SecondBuildingApplicationsController < ApplicationController
  layout 'form'
  # GET /form/second_building_applications
  # GET /form/second_building_applications.json
  def index
    @form_second_building_applications = Form::SecondBuildingApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @form_second_building_applications }
    end
  end

  # GET /form/second_building_applications/1
  # GET /form/second_building_applications/1.json
  def show
    @form = Form::SecondBuildingApplication.find(params[:id])

    @group = @form.group

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @form_second_building_application }
    end
  end

  # GET /form/second_building_applications/new
  # GET /form/second_building_applications/new.json
  def new
    @group = Group.find(params[:id])
    @form_second_building_application = @group.second_building_applications.build 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form_second_building_application }
    end
  end

  # GET /form/second_building_applications/1/edit
  def edit
    @form_second_building_application = Form::SecondBuildingApplication.find(params[:id])
  end

  # POST /form/second_building_applications
  # POST /form/second_building_applications.json
  def create
    @form_second_building_application = Form::SecondBuildingApplication.new(params[:form_second_building_application])
    @form_second_building_application.status = Constant::Approving

    respond_to do |format|
      if @form_second_building_application.save
        format.html { redirect_to @form_second_building_application, notice: 'Second building application was successfully created.' }
        format.json { render json: @form_second_building_application, status: :created, location: @form_second_building_application }
      else
        format.html { render action: "new" }
        format.json { render json: @form_second_building_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /form/second_building_applications/1
  # PUT /form/second_building_applications/1.json
  def update
    @form_second_building_application = Form::SecondBuildingApplication.find(params[:id])

    respond_to do |format|
      if @form_second_building_application.update_attributes(params[:form_second_building_application])
        format.html { redirect_to admin_forms_path, notice: 'Second building application was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @form_second_building_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form/second_building_applications/1
  # DELETE /form/second_building_applications/1.json
  def destroy
    @form_second_building_application = Form::SecondBuildingApplication.find(params[:id])
    @form_second_building_application.destroy

    redirect_to admin_forms_index_path

  end


  def approve
    @form_second_building_application = Form::SecondBuildingApplication.find(params[:id])
    @form_second_building_application.status = Constant::Approved
    @form_second_building_application.save

    redirect_to :back
  end

  def reject
    @form_second_building_application = Form::SecondBuildingApplication.find(params[:id])
    @form_second_building_application.status = Constant::Rejected
    @form_second_building_application.save

    redirect_to :back
  end
end
