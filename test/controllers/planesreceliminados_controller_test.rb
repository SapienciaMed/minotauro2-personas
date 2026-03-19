require 'test_helper'

class PlanesreceliminadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesreceliminado = planesreceliminados(:one)
  end

  test "should get index" do
    get planesreceliminados_url
    assert_response :success
  end

  test "should get new" do
    get new_planesreceliminado_url
    assert_response :success
  end

  test "should create planesreceliminado" do
    assert_difference('Planesreceliminado.count') do
      post planesreceliminados_url, params: { planesreceliminado: { capital: @planesreceliminado.capital, corriente: @planesreceliminado.corriente, denominacion: @planesreceliminado.denominacion, estado_envio: @planesreceliminado.estado_envio, fchreal_registro: @planesreceliminado.fchreal_registro, fecha_movimiento: @planesreceliminado.fecha_movimiento, fecha_recaudo: @planesreceliminado.fecha_recaudo, mora: @planesreceliminado.mora, obser_anulacion: @planesreceliminado.obser_anulacion, observacion: @planesreceliminado.observacion, otros: @planesreceliminado.otros, parorigenespago_id: @planesreceliminado.parorigenespago_id, personasobligacion_id: @planesreceliminado.personasobligacion_id, planesrecaudo_id: @planesreceliminado.planesrecaudo_id, portafolio_id: @planesreceliminado.portafolio_id, portafolioscuenta_id: @planesreceliminado.portafolioscuenta_id, portafoliossucursal_id: @planesreceliminado.portafoliossucursal_id, seguro: @planesreceliminado.seguro, sfc: @planesreceliminado.sfc, tipo_afecta: @planesreceliminado.tipo_afecta, tipo_pago: @planesreceliminado.tipo_pago, user_id: @planesreceliminado.user_id, useranula_id: @planesreceliminado.useranula_id, valor: @planesreceliminado.valor } }
    end

    assert_redirected_to planesreceliminado_url(Planesreceliminado.last)
  end

  test "should show planesreceliminado" do
    get planesreceliminado_url(@planesreceliminado)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesreceliminado_url(@planesreceliminado)
    assert_response :success
  end

  test "should update planesreceliminado" do
    patch planesreceliminado_url(@planesreceliminado), params: { planesreceliminado: { capital: @planesreceliminado.capital, corriente: @planesreceliminado.corriente, denominacion: @planesreceliminado.denominacion, estado_envio: @planesreceliminado.estado_envio, fchreal_registro: @planesreceliminado.fchreal_registro, fecha_movimiento: @planesreceliminado.fecha_movimiento, fecha_recaudo: @planesreceliminado.fecha_recaudo, mora: @planesreceliminado.mora, obser_anulacion: @planesreceliminado.obser_anulacion, observacion: @planesreceliminado.observacion, otros: @planesreceliminado.otros, parorigenespago_id: @planesreceliminado.parorigenespago_id, personasobligacion_id: @planesreceliminado.personasobligacion_id, planesrecaudo_id: @planesreceliminado.planesrecaudo_id, portafolio_id: @planesreceliminado.portafolio_id, portafolioscuenta_id: @planesreceliminado.portafolioscuenta_id, portafoliossucursal_id: @planesreceliminado.portafoliossucursal_id, seguro: @planesreceliminado.seguro, sfc: @planesreceliminado.sfc, tipo_afecta: @planesreceliminado.tipo_afecta, tipo_pago: @planesreceliminado.tipo_pago, user_id: @planesreceliminado.user_id, useranula_id: @planesreceliminado.useranula_id, valor: @planesreceliminado.valor } }
    assert_redirected_to planesreceliminado_url(@planesreceliminado)
  end

  test "should destroy planesreceliminado" do
    assert_difference('Planesreceliminado.count', -1) do
      delete planesreceliminado_url(@planesreceliminado)
    end

    assert_redirected_to planesreceliminados_url
  end
end
