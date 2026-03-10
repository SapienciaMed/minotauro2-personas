require 'test_helper'

class TiposprocesosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposproceso = tiposprocesos(:one)
  end

  test "should get index" do
    get tiposprocesos_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposproceso_url
    assert_response :success
  end

  test "should create tiposproceso" do
    assert_difference('Tiposproceso.count') do
      post tiposprocesos_url, params: { tiposproceso: { descripcion: @tiposproceso.descripcion, user_id: @tiposproceso.user_id } }
    end

    assert_redirected_to tiposproceso_url(Tiposproceso.last)
  end

  test "should show tiposproceso" do
    get tiposproceso_url(@tiposproceso)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposproceso_url(@tiposproceso)
    assert_response :success
  end

  test "should update tiposproceso" do
    patch tiposproceso_url(@tiposproceso), params: { tiposproceso: { descripcion: @tiposproceso.descripcion, user_id: @tiposproceso.user_id } }
    assert_redirected_to tiposproceso_url(@tiposproceso)
  end

  test "should destroy tiposproceso" do
    assert_difference('Tiposproceso.count', -1) do
      delete tiposproceso_url(@tiposproceso)
    end

    assert_redirected_to tiposprocesos_url
  end
end
