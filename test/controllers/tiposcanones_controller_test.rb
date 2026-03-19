require 'test_helper'

class TiposcanonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposcanon = tiposcanones(:one)
  end

  test "should get index" do
    get tiposcanones_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposcanon_url
    assert_response :success
  end

  test "should create tiposcanon" do
    assert_difference('Tiposcanon.count') do
      post tiposcanones_url, params: { tiposcanon: { descripcion: @tiposcanon.descripcion, nombre: @tiposcanon.nombre, portafolio_id: @tiposcanon.portafolio_id, user_act: @tiposcanon.user_act, user_id: @tiposcanon.user_id } }
    end

    assert_redirected_to tiposcanon_url(Tiposcanon.last)
  end

  test "should show tiposcanon" do
    get tiposcanon_url(@tiposcanon)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposcanon_url(@tiposcanon)
    assert_response :success
  end

  test "should update tiposcanon" do
    patch tiposcanon_url(@tiposcanon), params: { tiposcanon: { descripcion: @tiposcanon.descripcion, nombre: @tiposcanon.nombre, portafolio_id: @tiposcanon.portafolio_id, user_act: @tiposcanon.user_act, user_id: @tiposcanon.user_id } }
    assert_redirected_to tiposcanon_url(@tiposcanon)
  end

  test "should destroy tiposcanon" do
    assert_difference('Tiposcanon.count', -1) do
      delete tiposcanon_url(@tiposcanon)
    end

    assert_redirected_to tiposcanones_url
  end
end
