require 'test_helper'

class Form::SecondBuildingApplicationFormsControllerTest < ActionController::TestCase
  setup do
    @form_second_building_application_form = form_second_building_application_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:form_second_building_application_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create form_second_building_application_form" do
    assert_difference('Form::SecondBuildingApplicationForm.count') do
      post :create, form_second_building_application_form: @form_second_building_application_form.attributes
    end

    assert_redirected_to form_second_building_application_form_path(assigns(:form_second_building_application_form))
  end

  test "should show form_second_building_application_form" do
    get :show, id: @form_second_building_application_form.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @form_second_building_application_form.to_param
    assert_response :success
  end

  test "should update form_second_building_application_form" do
    put :update, id: @form_second_building_application_form.to_param, form_second_building_application_form: @form_second_building_application_form.attributes
    assert_redirected_to form_second_building_application_form_path(assigns(:form_second_building_application_form))
  end

  test "should destroy form_second_building_application_form" do
    assert_difference('Form::SecondBuildingApplicationForm.count', -1) do
      delete :destroy, id: @form_second_building_application_form.to_param
    end

    assert_redirected_to form_second_building_application_forms_path
  end
end
