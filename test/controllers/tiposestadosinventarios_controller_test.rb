require 'test_helper'

class TiposestadosinventariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestadosinventario = tiposestadosinventarios(:one)
  end

  test "should get index" do
    get tiposestadosinventarios_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestadosinventario_url
    assert_response :success
  end

  test "should create tiposestadosinventario" do
    assert_difference('Tiposestadosinventario.count') do
      post tiposestadosinventarios_url, params: { tiposestadosinventario: { descripcion: @tiposestadosinventario.descripcion, portafolio_id: @tiposestadosinventario.portafolio_id, user_act: @tiposestadosinventario.user_act, user_id: @tiposestadosinventario.user_id } }
    end

    assert_redirected_to tiposestadosinventario_url(Tiposestadosinventario.last)
  end

  test "should show tiposestadosinventario" do
    get tiposestadosinventario_url(@tiposestadosinventario)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestadosinventario_url(@tiposestadosinventario)
    assert_response :success
  end

  test "should update tiposestadosinventario" do
    patch tiposestadosinventario_url(@tiposestadosinventario), params: { tiposestadosinventario: { descripcion: @tiposestadosinventario.descripcion, portafolio_id: @tiposestadosinventario.portafolio_id, user_act: @tiposestadosinventario.user_act, user_id: @tiposestadosinventario.user_id } }
    assert_redirected_to tiposestadosinventario_url(@tiposestadosinventario)
  end

  test "should destroy tiposestadosinventario" do
    assert_difference('Tiposestadosinventario.count', -1) do
      delete tiposestadosinventario_url(@tiposestadosinventario)
    end

    assert_redirected_to tiposestadosinventarios_url
  end
end
