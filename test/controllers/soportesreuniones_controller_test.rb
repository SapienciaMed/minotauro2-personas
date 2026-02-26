require 'test_helper'

class SoportesreunionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @soportesreunion = soportesreuniones(:one)
  end

  test "should get index" do
    get soportesreuniones_url
    assert_response :success
  end

  test "should get new" do
    get new_soportesreunion_url
    assert_response :success
  end

  test "should create soportesreunion" do
    assert_difference('Soportesreunion.count') do
      post soportesreuniones_url, params: { soportesreunion: { fecha: @soportesreunion.fecha, observacion: @soportesreunion.observacion, soporte_id: @soportesreunion.soporte_id, user_id: @soportesreunion.user_id } }
    end

    assert_redirected_to soportesreunion_url(Soportesreunion.last)
  end

  test "should show soportesreunion" do
    get soportesreunion_url(@soportesreunion)
    assert_response :success
  end

  test "should get edit" do
    get edit_soportesreunion_url(@soportesreunion)
    assert_response :success
  end

  test "should update soportesreunion" do
    patch soportesreunion_url(@soportesreunion), params: { soportesreunion: { fecha: @soportesreunion.fecha, observacion: @soportesreunion.observacion, soporte_id: @soportesreunion.soporte_id, user_id: @soportesreunion.user_id } }
    assert_redirected_to soportesreunion_url(@soportesreunion)
  end

  test "should destroy soportesreunion" do
    assert_difference('Soportesreunion.count', -1) do
      delete soportesreunion_url(@soportesreunion)
    end

    assert_redirected_to soportesreuniones_url
  end
end
