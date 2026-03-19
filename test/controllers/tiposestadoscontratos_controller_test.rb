require 'test_helper'

class TiposestadoscontratosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestadoscontrato = tiposestadoscontratos(:one)
  end

  test "should get index" do
    get tiposestadoscontratos_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestadoscontrato_url
    assert_response :success
  end

  test "should create tiposestadoscontrato" do
    assert_difference('Tiposestadoscontrato.count') do
      post tiposestadoscontratos_url, params: { tiposestadoscontrato: { descripcion: @tiposestadoscontrato.descripcion, nombre: @tiposestadoscontrato.nombre, portafolio_id: @tiposestadoscontrato.portafolio_id, user_act: @tiposestadoscontrato.user_act, user_id: @tiposestadoscontrato.user_id } }
    end

    assert_redirected_to tiposestadoscontrato_url(Tiposestadoscontrato.last)
  end

  test "should show tiposestadoscontrato" do
    get tiposestadoscontrato_url(@tiposestadoscontrato)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestadoscontrato_url(@tiposestadoscontrato)
    assert_response :success
  end

  test "should update tiposestadoscontrato" do
    patch tiposestadoscontrato_url(@tiposestadoscontrato), params: { tiposestadoscontrato: { descripcion: @tiposestadoscontrato.descripcion, nombre: @tiposestadoscontrato.nombre, portafolio_id: @tiposestadoscontrato.portafolio_id, user_act: @tiposestadoscontrato.user_act, user_id: @tiposestadoscontrato.user_id } }
    assert_redirected_to tiposestadoscontrato_url(@tiposestadoscontrato)
  end

  test "should destroy tiposestadoscontrato" do
    assert_difference('Tiposestadoscontrato.count', -1) do
      delete tiposestadoscontrato_url(@tiposestadoscontrato)
    end

    assert_redirected_to tiposestadoscontratos_url
  end
end
