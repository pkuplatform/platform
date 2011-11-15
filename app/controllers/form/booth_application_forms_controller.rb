class Form::BoothApplicationFormsController < ApplicationController
  # GET /form/booth_application_forms
  # GET /form/booth_application_forms.json
  def index
    @form_booth_application_forms = Form::BoothApplicationForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @form_booth_application_forms }
    end
  end

  # GET /form/booth_application_forms/1
  # GET /form/booth_application_forms/1.json
  def show
    @form_booth_application_form = Form::BoothApplicationForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @form_booth_application_form }
    end
  end

  # GET /form/booth_application_forms/new
  # GET /form/booth_application_forms/new.json
  def new
    @form_booth_application_form = Form::BoothApplicationForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form_booth_application_form }
    end
  end

  # GET /form/booth_application_forms/1/edit
  def edit
    @form_booth_application_form = Form::BoothApplicationForm.find(params[:id])
  end

  # POST /form/booth_application_forms
  # POST /form/booth_application_forms.json
  def create
    @form_booth_application_form = Form::BoothApplicationForm.new(params[:form_booth_application_form])

    respond_to do |format|
      if @form_booth_application_form.save
        format.html { redirect_to @form_booth_application_form, notice: 'Booth application form was successfully created.' }
        format.json { render json: @form_booth_application_form, status: :created, location: @form_booth_application_form }
      else
        format.html { render action: "new" }
        format.json { render json: @form_booth_application_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /form/booth_application_forms/1
  # PUT /form/booth_application_forms/1.json
  def update
    @form_booth_application_form = Form::BoothApplicationForm.find(params[:id])

    respond_to do |format|
      if @form_booth_application_form.update_attributes(params[:form_booth_application_form])
        format.html { redirect_to @form_booth_application_form, notice: 'Booth application form was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @form_booth_application_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form/booth_application_forms/1
  # DELETE /form/booth_application_forms/1.json
  def destroy
    @form_booth_application_form = Form::BoothApplicationForm.find(params[:id])
    @form_booth_application_form.destroy

    respond_to do |format|
      format.html { redirect_to form_booth_application_forms_url }
      format.json { head :ok }
    end
  end
end
