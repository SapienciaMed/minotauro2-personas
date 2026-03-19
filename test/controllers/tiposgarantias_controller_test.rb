require 'test_helper'

class TiposgarantiasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposgarantia = tiposgarantias(:one)
  end

  test "should get index" do
    get tiposgarantias_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposgarantia_url
    assert_response :success
  end

  test "should create tiposgarantia" do
    assert_difference('Tiposgarantia.count') do
      post tiposgarantias_url, params: { tiposgarantia: { descripcion: @tiposgarantia.descripcion, detalle: @tiposgarantia.detalle, estado: @tiposgarantia.estado } }
    end

    assert_redirected_to tiposgarantia_url(Tiposgarantia.last)
  end

  test "should show tiposgarantia" do
    get tiposgarantia_url(@tiposgarantia)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposgarantia_url(@tiposgarantia)
    assert_response :success
  end

  test "should update tiposgarantia" do
    patch tiposgarantia_url(@tiposgarantia), params: { tiposgarantia: { descripcion: @tiposgarantia.descripcion, detalle: @tiposgarantia.detalle, estado: @tiposgarantia.estado } }
    assert_redirected_to tiposgarantia_url(@tiposgarantia)
  end

  test "should destroy tiposgarantia" do
    assert_difference('Tiposgarantia.count', -1) do
      delete tiposgarantia_url(@tiposgarantia)
    end

    assert_redirected_to tiposgarantias_url
  end
end
