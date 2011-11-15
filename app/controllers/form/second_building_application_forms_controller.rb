class Form::SecondBuildingApplicationFormsController < ApplicationController
  # GET /form/second_building_application_forms
  # GET /form/second_building_application_forms.json
  def index
    @form_second_building_application_forms = Form::SecondBuildingApplicationForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @form_second_building_application_forms }
    end
  end

  # GET /form/second_building_application_forms/1
  # GET /form/second_building_application_forms/1.json
  def show
    @form_second_building_application_form = Form::SecondBuildingApplicationForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @form_second_building_application_form }
    end
  end

  # GET /form/second_building_application_forms/new
  # GET /form/second_building_application_forms/new.json
  def new
    @form_second_building_application_form = Form::SecondBuildingApplicationForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form_second_building_application_form }
    end
  end

  # GET /form/second_building_application_forms/1/edit
  def edit
    @form_second_building_application_form = Form::SecondBuildingApplicationForm.find(params[:id])
  end

  # POST /form/second_building_application_forms
  # POST /form/second_building_application_forms.json
  def create
    @form_second_building_application_form = Form::SecondBuildingApplicationForm.new(params[:form_second_building_application_form])

    respond_to do |format|
      if @form_second_building_application_form.save
        format.html { redirect_to @form_second_building_application_form, notice: 'Second building application form was successfully created.' }
        format.json { render json: @form_second_building_application_form, status: :created, location: @form_second_building_application_form }
      else
        format.html { render action: "new" }
        format.json { render json: @form_second_building_application_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /form/second_building_application_forms/1
  # PUT /form/second_building_application_forms/1.json
  def update
    @form_second_building_application_form = Form::SecondBuildingApplicationForm.find(params[:id])

    respond_to do |format|
      if @form_second_building_application_form.update_attributes(params[:form_second_building_application_form])
        format.html { redirect_to @form_second_building_application_form, notice: 'Second building application form was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @form_second_building_application_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form/second_building_application_forms/1
  # DELETE /form/second_building_application_forms/1.json
  def destroy
    @form_second_building_application_form = Form::SecondBuildingApplicationForm.find(params[:id])
    @form_second_building_application_form.destroy

    respond_to do |format|
      format.html { redirect_to form_second_building_application_forms_url }
      format.json { head :ok }
    end
  end
end
