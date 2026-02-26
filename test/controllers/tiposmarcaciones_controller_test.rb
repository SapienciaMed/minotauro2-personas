require 'test_helper'

class TiposmarcacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposmarcacion = tiposmarcaciones(:one)
  end

  test "should get index" do
    get tiposmarcaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposmarcacion_url
    assert_response :success
  end

  test "should create tiposmarcacion" do
    assert_difference('Tiposmarcacion.count') do
      post tiposmarcaciones_url, params: { tiposmarcacion: { descripcion: @tiposmarcacion.descripcion, detalle: @tiposmarcacion.detalle, estado: @tiposmarcacion.estado } }
    end

    assert_redirected_to tiposmarcacion_url(Tiposmarcacion.last)
  end

  test "should show tiposmarcacion" do
    get tiposmarcacion_url(@tiposmarcacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposmarcacion_url(@tiposmarcacion)
    assert_response :success
  end

  test "should update tiposmarcacion" do
    patch tiposmarcacion_url(@tiposmarcacion), params: { tiposmarcacion: { descripcion: @tiposmarcacion.descripcion, detalle: @tiposmarcacion.detalle, estado: @tiposmarcacion.estado } }
    assert_redirected_to tiposmarcacion_url(@tiposmarcacion)
  end

  test "should destroy tiposmarcacion" do
    assert_difference('Tiposmarcacion.count', -1) do
      delete tiposmarcacion_url(@tiposmarcacion)
    end

    assert_redirected_to tiposmarcaciones_url
  end
end
