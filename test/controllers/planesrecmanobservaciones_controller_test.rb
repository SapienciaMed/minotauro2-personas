require 'test_helper'

class PlanesrecmanobservacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesrecmanobservacion = planesrecmanobservaciones(:one)
  end

  test "should get index" do
    get planesrecmanobservaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_planesrecmanobservacion_url
    assert_response :success
  end

  test "should create planesrecmanobservacion" do
    assert_difference('Planesrecmanobservacion.count') do
      post planesrecmanobservaciones_url, params: { planesrecmanobservacion: { observacion: @planesrecmanobservacion.observacion, planesrecmanual_id: @planesrecmanobservacion.planesrecmanual_id, user_id: @planesrecmanobservacion.user_id } }
    end

    assert_redirected_to planesrecmanobservacion_url(Planesrecmanobservacion.last)
  end

  test "should show planesrecmanobservacion" do
    get planesrecmanobservacion_url(@planesrecmanobservacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesrecmanobservacion_url(@planesrecmanobservacion)
    assert_response :success
  end

  test "should update planesrecmanobservacion" do
    patch planesrecmanobservacion_url(@planesrecmanobservacion), params: { planesrecmanobservacion: { observacion: @planesrecmanobservacion.observacion, planesrecmanual_id: @planesrecmanobservacion.planesrecmanual_id, user_id: @planesrecmanobservacion.user_id } }
    assert_redirected_to planesrecmanobservacion_url(@planesrecmanobservacion)
  end

  test "should destroy planesrecmanobservacion" do
    assert_difference('Planesrecmanobservacion.count', -1) do
      delete planesrecmanobservacion_url(@planesrecmanobservacion)
    end

    assert_redirected_to planesrecmanobservaciones_url
  end
end
