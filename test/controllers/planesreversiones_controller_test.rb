require 'test_helper'

class PlanesreversionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesreversion = planesreversiones(:one)
  end

  test "should get index" do
    get planesreversiones_url
    assert_response :success
  end

  test "should get new" do
    get new_planesreversion_url
    assert_response :success
  end

  test "should create planesreversion" do
    assert_difference('Planesreversion.count') do
      post planesreversiones_url, params: { planesreversion: { estado: @planesreversion.estado, observacion_reversion: @planesreversion.observacion_reversion, personasobligacion_id: @planesreversion.personasobligacion_id, planesrecaudo_id: @planesreversion.planesrecaudo_id, portafolio_id: @planesreversion.portafolio_id, tipo: @planesreversion.tipo, user_id: @planesreversion.user_id } }
    end

    assert_redirected_to planesreversion_url(Planesreversion.last)
  end

  test "should show planesreversion" do
    get planesreversion_url(@planesreversion)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesreversion_url(@planesreversion)
    assert_response :success
  end

  test "should update planesreversion" do
    patch planesreversion_url(@planesreversion), params: { planesreversion: { estado: @planesreversion.estado, observacion_reversion: @planesreversion.observacion_reversion, personasobligacion_id: @planesreversion.personasobligacion_id, planesrecaudo_id: @planesreversion.planesrecaudo_id, portafolio_id: @planesreversion.portafolio_id, tipo: @planesreversion.tipo, user_id: @planesreversion.user_id } }
    assert_redirected_to planesreversion_url(@planesreversion)
  end

  test "should destroy planesreversion" do
    assert_difference('Planesreversion.count', -1) do
      delete planesreversion_url(@planesreversion)
    end

    assert_redirected_to planesreversiones_url
  end
end
