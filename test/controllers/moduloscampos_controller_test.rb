require 'test_helper'

class ModuloscamposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @moduloscampo = moduloscampos(:one)
  end

  test "should get index" do
    get moduloscampos_url
    assert_response :success
  end

  test "should get new" do
    get new_moduloscampo_url
    assert_response :success
  end

  test "should create moduloscampo" do
    assert_difference('Moduloscampo.count') do
      post moduloscampos_url, params: { moduloscampo: { campo: @moduloscampo.campo, detalle: @moduloscampo.detalle, encabezado: @moduloscampo.encabezado, modulo_id: @moduloscampo.modulo_id, orden: @moduloscampo.orden, tipo: @moduloscampo.tipo } }
    end

    assert_redirected_to moduloscampo_url(Moduloscampo.last)
  end

  test "should show moduloscampo" do
    get moduloscampo_url(@moduloscampo)
    assert_response :success
  end

  test "should get edit" do
    get edit_moduloscampo_url(@moduloscampo)
    assert_response :success
  end

  test "should update moduloscampo" do
    patch moduloscampo_url(@moduloscampo), params: { moduloscampo: { campo: @moduloscampo.campo, detalle: @moduloscampo.detalle, encabezado: @moduloscampo.encabezado, modulo_id: @moduloscampo.modulo_id, orden: @moduloscampo.orden, tipo: @moduloscampo.tipo } }
    assert_redirected_to moduloscampo_url(@moduloscampo)
  end

  test "should destroy moduloscampo" do
    assert_difference('Moduloscampo.count', -1) do
      delete moduloscampo_url(@moduloscampo)
    end

    assert_redirected_to moduloscampos_url
  end
end
