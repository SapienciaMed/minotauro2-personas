require 'test_helper'

class PortafoliosgpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @portafoliosgp = portafoliosgps(:one)
  end

  test "should get index" do
    get portafoliosgps_url
    assert_response :success
  end

  test "should get new" do
    get new_portafoliosgp_url
    assert_response :success
  end

  test "should create portafoliosgp" do
    assert_difference('Portafoliosgp.count') do
      post portafoliosgps_url, params: { portafoliosgp: { portafolio_id: @portafoliosgp.portafolio_id } }
    end

    assert_redirected_to portafoliosgp_url(Portafoliosgp.last)
  end

  test "should show portafoliosgp" do
    get portafoliosgp_url(@portafoliosgp)
    assert_response :success
  end

  test "should get edit" do
    get edit_portafoliosgp_url(@portafoliosgp)
    assert_response :success
  end

  test "should update portafoliosgp" do
    patch portafoliosgp_url(@portafoliosgp), params: { portafoliosgp: { portafolio_id: @portafoliosgp.portafolio_id } }
    assert_redirected_to portafoliosgp_url(@portafoliosgp)
  end

  test "should destroy portafoliosgp" do
    assert_difference('Portafoliosgp.count', -1) do
      delete portafoliosgp_url(@portafoliosgp)
    end

    assert_redirected_to portafoliosgps_url
  end
end
