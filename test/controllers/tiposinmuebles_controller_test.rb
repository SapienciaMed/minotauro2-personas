require 'test_helper'

class TiposinmueblesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposinmueble = tiposinmuebles(:one)
  end

  test "should get index" do
    get tiposinmuebles_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposinmueble_url
    assert_response :success
  end

  test "should create tiposinmueble" do
    assert_difference('Tiposinmueble.count') do
      post tiposinmuebles_url, params: { tiposinmueble: { descripcion: @tiposinmueble.descripcion, portafolio_id: @tiposinmueble.portafolio_id, user_id: @tiposinmueble.user_id } }
    end

    assert_redirected_to tiposinmueble_url(Tiposinmueble.last)
  end

  test "should show tiposinmueble" do
    get tiposinmueble_url(@tiposinmueble)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposinmueble_url(@tiposinmueble)
    assert_response :success
  end

  test "should update tiposinmueble" do
    patch tiposinmueble_url(@tiposinmueble), params: { tiposinmueble: { descripcion: @tiposinmueble.descripcion, portafolio_id: @tiposinmueble.portafolio_id, user_id: @tiposinmueble.user_id } }
    assert_redirected_to tiposinmueble_url(@tiposinmueble)
  end

  test "should destroy tiposinmueble" do
    assert_difference('Tiposinmueble.count', -1) do
      delete tiposinmueble_url(@tiposinmueble)
    end

    assert_redirected_to tiposinmuebles_url
  end
end
