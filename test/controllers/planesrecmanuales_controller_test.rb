require 'test_helper'

class PlanesrecmanualesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesrecmanual = planesrecmanuales(:one)
  end

  test "should get index" do
    get planesrecmanuales_url
    assert_response :success
  end

  test "should get new" do
    get new_planesrecmanual_url
    assert_response :success
  end

  test "should create planesrecmanual" do
    assert_difference('Planesrecmanual.count') do
      post planesrecmanuales_url, params: { planesrecmanual: { estado: @planesrecmanual.estado, fecha_aprobacion: @planesrecmanual.fecha_aprobacion, fecha_recaudo: @planesrecmanual.fecha_recaudo, observacion: @planesrecmanual.observacion, observacion_aprobacion: @planesrecmanual.observacion_aprobacion, personasobligacion_id: @planesrecmanual.personasobligacion_id, portafolio_id: @planesrecmanual.portafolio_id, tanque_id: @planesrecmanual.tanque_id, tipo_pago: @planesrecmanual.tipo_pago, unidad_denominacion: @planesrecmanual.unidad_denominacion, user_aprobacion: @planesrecmanual.user_aprobacion, valor: @planesrecmanual.valor } }
    end

    assert_redirected_to planesrecmanual_url(Planesrecmanual.last)
  end

  test "should show planesrecmanual" do
    get planesrecmanual_url(@planesrecmanual)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesrecmanual_url(@planesrecmanual)
    assert_response :success
  end

  test "should update planesrecmanual" do
    patch planesrecmanual_url(@planesrecmanual), params: { planesrecmanual: { estado: @planesrecmanual.estado, fecha_aprobacion: @planesrecmanual.fecha_aprobacion, fecha_recaudo: @planesrecmanual.fecha_recaudo, observacion: @planesrecmanual.observacion, observacion_aprobacion: @planesrecmanual.observacion_aprobacion, personasobligacion_id: @planesrecmanual.personasobligacion_id, portafolio_id: @planesrecmanual.portafolio_id, tanque_id: @planesrecmanual.tanque_id, tipo_pago: @planesrecmanual.tipo_pago, unidad_denominacion: @planesrecmanual.unidad_denominacion, user_aprobacion: @planesrecmanual.user_aprobacion, valor: @planesrecmanual.valor } }
    assert_redirected_to planesrecmanual_url(@planesrecmanual)
  end

  test "should destroy planesrecmanual" do
    assert_difference('Planesrecmanual.count', -1) do
      delete planesrecmanual_url(@planesrecmanual)
    end

    assert_redirected_to planesrecmanuales_url
  end
end
