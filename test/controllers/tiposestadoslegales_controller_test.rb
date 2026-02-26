require 'test_helper'

class TiposestadoslegalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestadoslegal = tiposestadoslegales(:one)
  end

  test "should get index" do
    get tiposestadoslegales_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestadoslegal_url
    assert_response :success
  end

  test "should create tiposestadoslegal" do
    assert_difference('Tiposestadoslegal.count') do
      post tiposestadoslegales_url, params: { tiposestadoslegal: { descripcion: @tiposestadoslegal.descripcion, portafolio_id: @tiposestadoslegal.portafolio_id, user_act: @tiposestadoslegal.user_act, user_id: @tiposestadoslegal.user_id } }
    end

    assert_redirected_to tiposestadoslegal_url(Tiposestadoslegal.last)
  end

  test "should show tiposestadoslegal" do
    get tiposestadoslegal_url(@tiposestadoslegal)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestadoslegal_url(@tiposestadoslegal)
    assert_response :success
  end

  test "should update tiposestadoslegal" do
    patch tiposestadoslegal_url(@tiposestadoslegal), params: { tiposestadoslegal: { descripcion: @tiposestadoslegal.descripcion, portafolio_id: @tiposestadoslegal.portafolio_id, user_act: @tiposestadoslegal.user_act, user_id: @tiposestadoslegal.user_id } }
    assert_redirected_to tiposestadoslegal_url(@tiposestadoslegal)
  end

  test "should destroy tiposestadoslegal" do
    assert_difference('Tiposestadoslegal.count', -1) do
      delete tiposestadoslegal_url(@tiposestadoslegal)
    end

    assert_redirected_to tiposestadoslegales_url
  end
end
