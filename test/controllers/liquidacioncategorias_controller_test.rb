require 'test_helper'

class LiquidacioncategoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liquidacioncategoria = liquidacioncategorias(:one)
  end

  test "should get index" do
    get liquidacioncategorias_url
    assert_response :success
  end

  test "should get new" do
    get new_liquidacioncategoria_url
    assert_response :success
  end

  test "should create liquidacioncategoria" do
    assert_difference('Liquidacioncategoria.count') do
      post liquidacioncategorias_url, params: { liquidacioncategoria: { nombre: @liquidacioncategoria.nombre, num_final: @liquidacioncategoria.num_final, num_inicio: @liquidacioncategoria.num_inicio } }
    end

    assert_redirected_to liquidacioncategoria_url(Liquidacioncategoria.last)
  end

  test "should show liquidacioncategoria" do
    get liquidacioncategoria_url(@liquidacioncategoria)
    assert_response :success
  end

  test "should get edit" do
    get edit_liquidacioncategoria_url(@liquidacioncategoria)
    assert_response :success
  end

  test "should update liquidacioncategoria" do
    patch liquidacioncategoria_url(@liquidacioncategoria), params: { liquidacioncategoria: { nombre: @liquidacioncategoria.nombre, num_final: @liquidacioncategoria.num_final, num_inicio: @liquidacioncategoria.num_inicio } }
    assert_redirected_to liquidacioncategoria_url(@liquidacioncategoria)
  end

  test "should destroy liquidacioncategoria" do
    assert_difference('Liquidacioncategoria.count', -1) do
      delete liquidacioncategoria_url(@liquidacioncategoria)
    end

    assert_redirected_to liquidacioncategorias_url
  end
end
