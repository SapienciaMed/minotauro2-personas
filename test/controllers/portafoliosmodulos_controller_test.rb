require 'test_helper'

class PortafoliosmodulosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @portafoliosmodulo = portafoliosmodulos(:one)
  end

  test "should get index" do
    get portafoliosmodulos_url
    assert_response :success
  end

  test "should get new" do
    get new_portafoliosmodulo_url
    assert_response :success
  end

  test "should create portafoliosmodulo" do
    assert_difference('Portafoliosmodulo.count') do
      post portafoliosmodulos_url, params: { portafoliosmodulo: { modulo_id: @portafoliosmodulo.modulo_id, portafolio_id: @portafoliosmodulo.portafolio_id } }
    end

    assert_redirected_to portafoliosmodulo_url(Portafoliosmodulo.last)
  end

  test "should show portafoliosmodulo" do
    get portafoliosmodulo_url(@portafoliosmodulo)
    assert_response :success
  end

  test "should get edit" do
    get edit_portafoliosmodulo_url(@portafoliosmodulo)
    assert_response :success
  end

  test "should update portafoliosmodulo" do
    patch portafoliosmodulo_url(@portafoliosmodulo), params: { portafoliosmodulo: { modulo_id: @portafoliosmodulo.modulo_id, portafolio_id: @portafoliosmodulo.portafolio_id } }
    assert_redirected_to portafoliosmodulo_url(@portafoliosmodulo)
  end

  test "should destroy portafoliosmodulo" do
    assert_difference('Portafoliosmodulo.count', -1) do
      delete portafoliosmodulo_url(@portafoliosmodulo)
    end

    assert_redirected_to portafoliosmodulos_url
  end
end
