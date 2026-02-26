require 'test_helper'

class TiposundmedidasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposundmedida = tiposundmedidas(:one)
  end

  test "should get index" do
    get tiposundmedidas_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposundmedida_url
    assert_response :success
  end

  test "should create tiposundmedida" do
    assert_difference('Tiposundmedida.count') do
      post tiposundmedidas_url, params: { tiposundmedida: { descripcion: @tiposundmedida.descripcion, portafolio_id: @tiposundmedida.portafolio_id, user_act: @tiposundmedida.user_act, user_id: @tiposundmedida.user_id } }
    end

    assert_redirected_to tiposundmedida_url(Tiposundmedida.last)
  end

  test "should show tiposundmedida" do
    get tiposundmedida_url(@tiposundmedida)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposundmedida_url(@tiposundmedida)
    assert_response :success
  end

  test "should update tiposundmedida" do
    patch tiposundmedida_url(@tiposundmedida), params: { tiposundmedida: { descripcion: @tiposundmedida.descripcion, portafolio_id: @tiposundmedida.portafolio_id, user_act: @tiposundmedida.user_act, user_id: @tiposundmedida.user_id } }
    assert_redirected_to tiposundmedida_url(@tiposundmedida)
  end

  test "should destroy tiposundmedida" do
    assert_difference('Tiposundmedida.count', -1) do
      delete tiposundmedida_url(@tiposundmedida)
    end

    assert_redirected_to tiposundmedidas_url
  end
end
