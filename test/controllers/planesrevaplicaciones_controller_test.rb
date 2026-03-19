require 'test_helper'

class PlanesrevaplicacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesrevaplicacion = planesrevaplicaciones(:one)
  end

  test "should get index" do
    get planesrevaplicaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_planesrevaplicacion_url
    assert_response :success
  end

  test "should create planesrevaplicacion" do
    assert_difference('Planesrevaplicacion.count') do
      post planesrevaplicaciones_url, params: { planesrevaplicacion: { estado1: @planesrevaplicacion.estado1, estado2: @planesrevaplicacion.estado2, estado3: @planesrevaplicacion.estado3, idplanesrecaudo: @planesrevaplicacion.idplanesrecaudo, planesreversion_id: @planesrevaplicacion.planesreversion_id } }
    end

    assert_redirected_to planesrevaplicacion_url(Planesrevaplicacion.last)
  end

  test "should show planesrevaplicacion" do
    get planesrevaplicacion_url(@planesrevaplicacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesrevaplicacion_url(@planesrevaplicacion)
    assert_response :success
  end

  test "should update planesrevaplicacion" do
    patch planesrevaplicacion_url(@planesrevaplicacion), params: { planesrevaplicacion: { estado1: @planesrevaplicacion.estado1, estado2: @planesrevaplicacion.estado2, estado3: @planesrevaplicacion.estado3, idplanesrecaudo: @planesrevaplicacion.idplanesrecaudo, planesreversion_id: @planesrevaplicacion.planesreversion_id } }
    assert_redirected_to planesrevaplicacion_url(@planesrevaplicacion)
  end

  test "should destroy planesrevaplicacion" do
    assert_difference('Planesrevaplicacion.count', -1) do
      delete planesrevaplicacion_url(@planesrevaplicacion)
    end

    assert_redirected_to planesrevaplicaciones_url
  end
end
