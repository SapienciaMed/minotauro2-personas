require 'test_helper'

class TiposserviciosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposservicio = tiposservicios(:one)
  end

  test "should get index" do
    get tiposservicios_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposservicio_url
    assert_response :success
  end

  test "should create tiposservicio" do
    assert_difference('Tiposservicio.count') do
      post tiposservicios_url, params: { tiposservicio: { descripcion: @tiposservicio.descripcion, estado: @tiposservicio.estado, tipo: @tiposservicio.tipo } }
    end

    assert_redirected_to tiposservicio_url(Tiposservicio.last)
  end

  test "should show tiposservicio" do
    get tiposservicio_url(@tiposservicio)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposservicio_url(@tiposservicio)
    assert_response :success
  end

  test "should update tiposservicio" do
    patch tiposservicio_url(@tiposservicio), params: { tiposservicio: { descripcion: @tiposservicio.descripcion, estado: @tiposservicio.estado, tipo: @tiposservicio.tipo } }
    assert_redirected_to tiposservicio_url(@tiposservicio)
  end

  test "should destroy tiposservicio" do
    assert_difference('Tiposservicio.count', -1) do
      delete tiposservicio_url(@tiposservicio)
    end

    assert_redirected_to tiposservicios_url
  end
end
