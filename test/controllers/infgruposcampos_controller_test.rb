require 'test_helper'

class InfgruposcamposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @infgruposcampo = infgruposcampos(:one)
  end

  test "should get index" do
    get infgruposcampos_url
    assert_response :success
  end

  test "should get new" do
    get new_infgruposcampo_url
    assert_response :success
  end

  test "should create infgruposcampo" do
    assert_difference('Infgruposcampo.count') do
      post infgruposcampos_url, params: { infgruposcampo: { campo: @infgruposcampo.campo, estilo: @infgruposcampo.estilo, estilo_encabezado: @infgruposcampo.estilo_encabezado, infgrupo_id: @infgruposcampo.infgrupo_id, nombre: @infgruposcampo.nombre, orden: @infgruposcampo.orden, tamano: @infgruposcampo.tamano, tipo: @infgruposcampo.tipo } }
    end

    assert_redirected_to infgruposcampo_url(Infgruposcampo.last)
  end

  test "should show infgruposcampo" do
    get infgruposcampo_url(@infgruposcampo)
    assert_response :success
  end

  test "should get edit" do
    get edit_infgruposcampo_url(@infgruposcampo)
    assert_response :success
  end

  test "should update infgruposcampo" do
    patch infgruposcampo_url(@infgruposcampo), params: { infgruposcampo: { campo: @infgruposcampo.campo, estilo: @infgruposcampo.estilo, estilo_encabezado: @infgruposcampo.estilo_encabezado, infgrupo_id: @infgruposcampo.infgrupo_id, nombre: @infgruposcampo.nombre, orden: @infgruposcampo.orden, tamano: @infgruposcampo.tamano, tipo: @infgruposcampo.tipo } }
    assert_redirected_to infgruposcampo_url(@infgruposcampo)
  end

  test "should destroy infgruposcampo" do
    assert_difference('Infgruposcampo.count', -1) do
      delete infgruposcampo_url(@infgruposcampo)
    end

    assert_redirected_to infgruposcampos_url
  end
end
