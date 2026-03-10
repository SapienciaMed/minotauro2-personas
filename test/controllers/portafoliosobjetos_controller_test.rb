require 'test_helper'

class PortafoliosobjetosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @portafoliosobjeto = portafoliosobjetos(:one)
  end

  test "should get index" do
    get portafoliosobjetos_url
    assert_response :success
  end

  test "should get new" do
    get new_portafoliosobjeto_url
    assert_response :success
  end

  test "should create portafoliosobjeto" do
    assert_difference('Portafoliosobjeto.count') do
      post portafoliosobjetos_url, params: { portafoliosobjeto: { objeto_id: @portafoliosobjeto.objeto_id, portafolio_id: @portafoliosobjeto.portafolio_id } }
    end

    assert_redirected_to portafoliosobjeto_url(Portafoliosobjeto.last)
  end

  test "should show portafoliosobjeto" do
    get portafoliosobjeto_url(@portafoliosobjeto)
    assert_response :success
  end

  test "should get edit" do
    get edit_portafoliosobjeto_url(@portafoliosobjeto)
    assert_response :success
  end

  test "should update portafoliosobjeto" do
    patch portafoliosobjeto_url(@portafoliosobjeto), params: { portafoliosobjeto: { objeto_id: @portafoliosobjeto.objeto_id, portafolio_id: @portafoliosobjeto.portafolio_id } }
    assert_redirected_to portafoliosobjeto_url(@portafoliosobjeto)
  end

  test "should destroy portafoliosobjeto" do
    assert_difference('Portafoliosobjeto.count', -1) do
      delete portafoliosobjeto_url(@portafoliosobjeto)
    end

    assert_redirected_to portafoliosobjetos_url
  end
end
