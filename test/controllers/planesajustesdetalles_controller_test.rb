require 'test_helper'

class PlanesajustesdetallesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesajustesdetalle = planesajustesdetalles(:one)
  end

  test "should get index" do
    get planesajustesdetalles_url
    assert_response :success
  end

  test "should get new" do
    get new_planesajustesdetalle_url
    assert_response :success
  end

  test "should create planesajustesdetalle" do
    assert_difference('Planesajustesdetalle.count') do
      post planesajustesdetalles_url, params: { planesajustesdetalle: { planesajuste_id: @planesajustesdetalle.planesajuste_id, planesrecaudo_id: @planesajustesdetalle.planesrecaudo_id, valor: @planesajustesdetalle.valor } }
    end

    assert_redirected_to planesajustesdetalle_url(Planesajustesdetalle.last)
  end

  test "should show planesajustesdetalle" do
    get planesajustesdetalle_url(@planesajustesdetalle)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesajustesdetalle_url(@planesajustesdetalle)
    assert_response :success
  end

  test "should update planesajustesdetalle" do
    patch planesajustesdetalle_url(@planesajustesdetalle), params: { planesajustesdetalle: { planesajuste_id: @planesajustesdetalle.planesajuste_id, planesrecaudo_id: @planesajustesdetalle.planesrecaudo_id, valor: @planesajustesdetalle.valor } }
    assert_redirected_to planesajustesdetalle_url(@planesajustesdetalle)
  end

  test "should destroy planesajustesdetalle" do
    assert_difference('Planesajustesdetalle.count', -1) do
      delete planesajustesdetalle_url(@planesajustesdetalle)
    end

    assert_redirected_to planesajustesdetalles_url
  end
end
