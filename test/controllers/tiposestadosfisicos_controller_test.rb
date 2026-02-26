require 'test_helper'

class TiposestadosfisicosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestadosfisico = tiposestadosfisicos(:one)
  end

  test "should get index" do
    get tiposestadosfisicos_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestadosfisico_url
    assert_response :success
  end

  test "should create tiposestadosfisico" do
    assert_difference('Tiposestadosfisico.count') do
      post tiposestadosfisicos_url, params: { tiposestadosfisico: { descripcion: @tiposestadosfisico.descripcion, portafolio_id: @tiposestadosfisico.portafolio_id, user_act: @tiposestadosfisico.user_act, user_id: @tiposestadosfisico.user_id } }
    end

    assert_redirected_to tiposestadosfisico_url(Tiposestadosfisico.last)
  end

  test "should show tiposestadosfisico" do
    get tiposestadosfisico_url(@tiposestadosfisico)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestadosfisico_url(@tiposestadosfisico)
    assert_response :success
  end

  test "should update tiposestadosfisico" do
    patch tiposestadosfisico_url(@tiposestadosfisico), params: { tiposestadosfisico: { descripcion: @tiposestadosfisico.descripcion, portafolio_id: @tiposestadosfisico.portafolio_id, user_act: @tiposestadosfisico.user_act, user_id: @tiposestadosfisico.user_id } }
    assert_redirected_to tiposestadosfisico_url(@tiposestadosfisico)
  end

  test "should destroy tiposestadosfisico" do
    assert_difference('Tiposestadosfisico.count', -1) do
      delete tiposestadosfisico_url(@tiposestadosfisico)
    end

    assert_redirected_to tiposestadosfisicos_url
  end
end
