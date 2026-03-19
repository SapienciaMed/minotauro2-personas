require 'test_helper'

class TiposestadosocupacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestadosocupacion = tiposestadosocupaciones(:one)
  end

  test "should get index" do
    get tiposestadosocupaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestadosocupacion_url
    assert_response :success
  end

  test "should create tiposestadosocupacion" do
    assert_difference('Tiposestadosocupacion.count') do
      post tiposestadosocupaciones_url, params: { tiposestadosocupacion: { descripcion: @tiposestadosocupacion.descripcion, portafolio_id: @tiposestadosocupacion.portafolio_id, user_act: @tiposestadosocupacion.user_act, user_id: @tiposestadosocupacion.user_id } }
    end

    assert_redirected_to tiposestadosocupacion_url(Tiposestadosocupacion.last)
  end

  test "should show tiposestadosocupacion" do
    get tiposestadosocupacion_url(@tiposestadosocupacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestadosocupacion_url(@tiposestadosocupacion)
    assert_response :success
  end

  test "should update tiposestadosocupacion" do
    patch tiposestadosocupacion_url(@tiposestadosocupacion), params: { tiposestadosocupacion: { descripcion: @tiposestadosocupacion.descripcion, portafolio_id: @tiposestadosocupacion.portafolio_id, user_act: @tiposestadosocupacion.user_act, user_id: @tiposestadosocupacion.user_id } }
    assert_redirected_to tiposestadosocupacion_url(@tiposestadosocupacion)
  end

  test "should destroy tiposestadosocupacion" do
    assert_difference('Tiposestadosocupacion.count', -1) do
      delete tiposestadosocupacion_url(@tiposestadosocupacion)
    end

    assert_redirected_to tiposestadosocupaciones_url
  end
end
