require 'test_helper'

class TiposdiscapacidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposdiscapacidad = tiposdiscapacidades(:one)
  end

  test "should get index" do
    get tiposdiscapacidades_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposdiscapacidad_url
    assert_response :success
  end

  test "should create tiposdiscapacidad" do
    assert_difference('Tiposdiscapacidad.count') do
      post tiposdiscapacidades_url, params: { tiposdiscapacidad: { codigo: @tiposdiscapacidad.codigo, descripcion: @tiposdiscapacidad.descripcion } }
    end

    assert_redirected_to tiposdiscapacidad_url(Tiposdiscapacidad.last)
  end

  test "should show tiposdiscapacidad" do
    get tiposdiscapacidad_url(@tiposdiscapacidad)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposdiscapacidad_url(@tiposdiscapacidad)
    assert_response :success
  end

  test "should update tiposdiscapacidad" do
    patch tiposdiscapacidad_url(@tiposdiscapacidad), params: { tiposdiscapacidad: { codigo: @tiposdiscapacidad.codigo, descripcion: @tiposdiscapacidad.descripcion } }
    assert_redirected_to tiposdiscapacidad_url(@tiposdiscapacidad)
  end

  test "should destroy tiposdiscapacidad" do
    assert_difference('Tiposdiscapacidad.count', -1) do
      delete tiposdiscapacidad_url(@tiposdiscapacidad)
    end

    assert_redirected_to tiposdiscapacidades_url
  end
end
