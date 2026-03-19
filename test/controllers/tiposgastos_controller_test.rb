require 'test_helper'

class TiposgastosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposgasto = tiposgastos(:one)
  end

  test "should get index" do
    get tiposgastos_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposgasto_url
    assert_response :success
  end

  test "should create tiposgasto" do
    assert_difference('Tiposgasto.count') do
      post tiposgastos_url, params: { tiposgasto: { descripcion: @tiposgasto.descripcion } }
    end

    assert_redirected_to tiposgasto_url(Tiposgasto.last)
  end

  test "should show tiposgasto" do
    get tiposgasto_url(@tiposgasto)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposgasto_url(@tiposgasto)
    assert_response :success
  end

  test "should update tiposgasto" do
    patch tiposgasto_url(@tiposgasto), params: { tiposgasto: { descripcion: @tiposgasto.descripcion } }
    assert_redirected_to tiposgasto_url(@tiposgasto)
  end

  test "should destroy tiposgasto" do
    assert_difference('Tiposgasto.count', -1) do
      delete tiposgasto_url(@tiposgasto)
    end

    assert_redirected_to tiposgastos_url
  end
end
