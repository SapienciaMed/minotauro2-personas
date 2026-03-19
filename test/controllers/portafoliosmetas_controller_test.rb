require 'test_helper'

class PortafoliosmetasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @portafoliosmeta = portafoliosmetas(:one)
  end

  test "should get index" do
    get portafoliosmetas_url
    assert_response :success
  end

  test "should get new" do
    get new_portafoliosmeta_url
    assert_response :success
  end

  test "should create portafoliosmeta" do
    assert_difference('Portafoliosmeta.count') do
      post portafoliosmetas_url, params: { portafoliosmeta: { anno: @portafoliosmeta.anno, mes: @portafoliosmeta.mes, portafolio_id: @portafoliosmeta.portafolio_id, user_id: @portafoliosmeta.user_id, valor: @portafoliosmeta.valor } }
    end

    assert_redirected_to portafoliosmeta_url(Portafoliosmeta.last)
  end

  test "should show portafoliosmeta" do
    get portafoliosmeta_url(@portafoliosmeta)
    assert_response :success
  end

  test "should get edit" do
    get edit_portafoliosmeta_url(@portafoliosmeta)
    assert_response :success
  end

  test "should update portafoliosmeta" do
    patch portafoliosmeta_url(@portafoliosmeta), params: { portafoliosmeta: { anno: @portafoliosmeta.anno, mes: @portafoliosmeta.mes, portafolio_id: @portafoliosmeta.portafolio_id, user_id: @portafoliosmeta.user_id, valor: @portafoliosmeta.valor } }
    assert_redirected_to portafoliosmeta_url(@portafoliosmeta)
  end

  test "should destroy portafoliosmeta" do
    assert_difference('Portafoliosmeta.count', -1) do
      delete portafoliosmeta_url(@portafoliosmeta)
    end

    assert_redirected_to portafoliosmetas_url
  end
end
