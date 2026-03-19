require 'test_helper'

class TiposusosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposuso = tiposusos(:one)
  end

  test "should get index" do
    get tiposusos_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposuso_url
    assert_response :success
  end

  test "should create tiposuso" do
    assert_difference('Tiposuso.count') do
      post tiposusos_url, params: { tiposuso: { descripcion: @tiposuso.descripcion, portafolio_id: @tiposuso.portafolio_id, user_act: @tiposuso.user_act, user_id: @tiposuso.user_id } }
    end

    assert_redirected_to tiposuso_url(Tiposuso.last)
  end

  test "should show tiposuso" do
    get tiposuso_url(@tiposuso)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposuso_url(@tiposuso)
    assert_response :success
  end

  test "should update tiposuso" do
    patch tiposuso_url(@tiposuso), params: { tiposuso: { descripcion: @tiposuso.descripcion, portafolio_id: @tiposuso.portafolio_id, user_act: @tiposuso.user_act, user_id: @tiposuso.user_id } }
    assert_redirected_to tiposuso_url(@tiposuso)
  end

  test "should destroy tiposuso" do
    assert_difference('Tiposuso.count', -1) do
      delete tiposuso_url(@tiposuso)
    end

    assert_redirected_to tiposusos_url
  end
end
