require 'test_helper'

class TiposestadoscuentasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestadoscuenta = tiposestadoscuentas(:one)
  end

  test "should get index" do
    get tiposestadoscuentas_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestadoscuenta_url
    assert_response :success
  end

  test "should create tiposestadoscuenta" do
    assert_difference('Tiposestadoscuenta.count') do
      post tiposestadoscuentas_url, params: { tiposestadoscuenta: { descripcion: @tiposestadoscuenta.descripcion, portafolio_id: @tiposestadoscuenta.portafolio_id, user_act: @tiposestadoscuenta.user_act, user_id: @tiposestadoscuenta.user_id } }
    end

    assert_redirected_to tiposestadoscuenta_url(Tiposestadoscuenta.last)
  end

  test "should show tiposestadoscuenta" do
    get tiposestadoscuenta_url(@tiposestadoscuenta)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestadoscuenta_url(@tiposestadoscuenta)
    assert_response :success
  end

  test "should update tiposestadoscuenta" do
    patch tiposestadoscuenta_url(@tiposestadoscuenta), params: { tiposestadoscuenta: { descripcion: @tiposestadoscuenta.descripcion, portafolio_id: @tiposestadoscuenta.portafolio_id, user_act: @tiposestadoscuenta.user_act, user_id: @tiposestadoscuenta.user_id } }
    assert_redirected_to tiposestadoscuenta_url(@tiposestadoscuenta)
  end

  test "should destroy tiposestadoscuenta" do
    assert_difference('Tiposestadoscuenta.count', -1) do
      delete tiposestadoscuenta_url(@tiposestadoscuenta)
    end

    assert_redirected_to tiposestadoscuentas_url
  end
end
