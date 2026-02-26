require 'test_helper'

class TratamientosdatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tratamientosdato = tratamientosdatos(:one)
  end

  test "should get index" do
    get tratamientosdatos_url
    assert_response :success
  end

  test "should get new" do
    get new_tratamientosdato_url
    assert_response :success
  end

  test "should create tratamientosdato" do
    assert_difference('Tratamientosdato.count') do
      post tratamientosdatos_url, params: { tratamientosdato: { identificacion_acudiente: @tratamientosdato.identificacion_acudiente, identificacion_becario: @tratamientosdato.identificacion_becario, nombre_acudiente: @tratamientosdato.nombre_acudiente, nombre_becario: @tratamientosdato.nombre_becario } }
    end

    assert_redirected_to tratamientosdato_url(Tratamientosdato.last)
  end

  test "should show tratamientosdato" do
    get tratamientosdato_url(@tratamientosdato)
    assert_response :success
  end

  test "should get edit" do
    get edit_tratamientosdato_url(@tratamientosdato)
    assert_response :success
  end

  test "should update tratamientosdato" do
    patch tratamientosdato_url(@tratamientosdato), params: { tratamientosdato: { identificacion_acudiente: @tratamientosdato.identificacion_acudiente, identificacion_becario: @tratamientosdato.identificacion_becario, nombre_acudiente: @tratamientosdato.nombre_acudiente, nombre_becario: @tratamientosdato.nombre_becario } }
    assert_redirected_to tratamientosdato_url(@tratamientosdato)
  end

  test "should destroy tratamientosdato" do
    assert_difference('Tratamientosdato.count', -1) do
      delete tratamientosdato_url(@tratamientosdato)
    end

    assert_redirected_to tratamientosdatos_url
  end
end
