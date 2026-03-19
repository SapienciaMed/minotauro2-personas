require 'test_helper'

class TiposnivelasignacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposnivelasignacion = tiposnivelasignaciones(:one)
  end

  test "should get index" do
    get tiposnivelasignaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposnivelasignacion_url
    assert_response :success
  end

  test "should create tiposnivelasignacion" do
    assert_difference('Tiposnivelasignacion.count') do
      post tiposnivelasignaciones_url, params: { tiposnivelasignacion: { descripcion: @tiposnivelasignacion.descripcion, nombre: @tiposnivelasignacion.nombre, portafolio_id: @tiposnivelasignacion.portafolio_id, user_act: @tiposnivelasignacion.user_act, user_id: @tiposnivelasignacion.user_id } }
    end

    assert_redirected_to tiposnivelasignacion_url(Tiposnivelasignacion.last)
  end

  test "should show tiposnivelasignacion" do
    get tiposnivelasignacion_url(@tiposnivelasignacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposnivelasignacion_url(@tiposnivelasignacion)
    assert_response :success
  end

  test "should update tiposnivelasignacion" do
    patch tiposnivelasignacion_url(@tiposnivelasignacion), params: { tiposnivelasignacion: { descripcion: @tiposnivelasignacion.descripcion, nombre: @tiposnivelasignacion.nombre, portafolio_id: @tiposnivelasignacion.portafolio_id, user_act: @tiposnivelasignacion.user_act, user_id: @tiposnivelasignacion.user_id } }
    assert_redirected_to tiposnivelasignacion_url(@tiposnivelasignacion)
  end

  test "should destroy tiposnivelasignacion" do
    assert_difference('Tiposnivelasignacion.count', -1) do
      delete tiposnivelasignacion_url(@tiposnivelasignacion)
    end

    assert_redirected_to tiposnivelasignaciones_url
  end
end
