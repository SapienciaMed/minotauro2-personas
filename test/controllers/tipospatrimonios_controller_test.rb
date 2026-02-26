require 'test_helper'

class TipospatrimoniosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipospatrimonio = tipospatrimonios(:one)
  end

  test "should get index" do
    get tipospatrimonios_url
    assert_response :success
  end

  test "should get new" do
    get new_tipospatrimonio_url
    assert_response :success
  end

  test "should create tipospatrimonio" do
    assert_difference('Tipospatrimonio.count') do
      post tipospatrimonios_url, params: { tipospatrimonio: { categoria: @tipospatrimonio.categoria, descripcion: @tipospatrimonio.descripcion, portafolio_id: @tipospatrimonio.portafolio_id, user_id: @tipospatrimonio.user_id } }
    end

    assert_redirected_to tipospatrimonio_url(Tipospatrimonio.last)
  end

  test "should show tipospatrimonio" do
    get tipospatrimonio_url(@tipospatrimonio)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipospatrimonio_url(@tipospatrimonio)
    assert_response :success
  end

  test "should update tipospatrimonio" do
    patch tipospatrimonio_url(@tipospatrimonio), params: { tipospatrimonio: { categoria: @tipospatrimonio.categoria, descripcion: @tipospatrimonio.descripcion, portafolio_id: @tipospatrimonio.portafolio_id, user_id: @tipospatrimonio.user_id } }
    assert_redirected_to tipospatrimonio_url(@tipospatrimonio)
  end

  test "should destroy tipospatrimonio" do
    assert_difference('Tipospatrimonio.count', -1) do
      delete tipospatrimonio_url(@tipospatrimonio)
    end

    assert_redirected_to tipospatrimonios_url
  end
end
