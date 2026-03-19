require 'test_helper'

class TiposaseguradorasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposaseguradora = tiposaseguradoras(:one)
  end

  test "should get index" do
    get tiposaseguradoras_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposaseguradora_url
    assert_response :success
  end

  test "should create tiposaseguradora" do
    assert_difference('Tiposaseguradora.count') do
      post tiposaseguradoras_url, params: { tiposaseguradora: { direccion: @tiposaseguradora.direccion, email: @tiposaseguradora.email, estado: @tiposaseguradora.estado, identificacion: @tiposaseguradora.identificacion, nombre: @tiposaseguradora.nombre, telefono: @tiposaseguradora.telefono } }
    end

    assert_redirected_to tiposaseguradora_url(Tiposaseguradora.last)
  end

  test "should show tiposaseguradora" do
    get tiposaseguradora_url(@tiposaseguradora)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposaseguradora_url(@tiposaseguradora)
    assert_response :success
  end

  test "should update tiposaseguradora" do
    patch tiposaseguradora_url(@tiposaseguradora), params: { tiposaseguradora: { direccion: @tiposaseguradora.direccion, email: @tiposaseguradora.email, estado: @tiposaseguradora.estado, identificacion: @tiposaseguradora.identificacion, nombre: @tiposaseguradora.nombre, telefono: @tiposaseguradora.telefono } }
    assert_redirected_to tiposaseguradora_url(@tiposaseguradora)
  end

  test "should destroy tiposaseguradora" do
    assert_difference('Tiposaseguradora.count', -1) do
      delete tiposaseguradora_url(@tiposaseguradora)
    end

    assert_redirected_to tiposaseguradoras_url
  end
end
