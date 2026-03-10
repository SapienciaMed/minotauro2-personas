require 'test_helper'

class PlanesrevdetallesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesrevdetalle = planesrevdetalles(:one)
  end

  test "should get index" do
    get planesrevdetalles_url
    assert_response :success
  end

  test "should get new" do
    get new_planesrevdetalle_url
    assert_response :success
  end

  test "should create planesrevdetalle" do
    assert_difference('Planesrevdetalle.count') do
      post planesrevdetalles_url, params: { planesrevdetalle: { estado1: @planesrevdetalle.estado1, estado2: @planesrevdetalle.estado2, estado3: @planesrevdetalle.estado3, idplanesrecaudo: @planesrevdetalle.idplanesrecaudo, planesreversion_id: @planesrevdetalle.planesreversion_id } }
    end

    assert_redirected_to planesrevdetalle_url(Planesrevdetalle.last)
  end

  test "should show planesrevdetalle" do
    get planesrevdetalle_url(@planesrevdetalle)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesrevdetalle_url(@planesrevdetalle)
    assert_response :success
  end

  test "should update planesrevdetalle" do
    patch planesrevdetalle_url(@planesrevdetalle), params: { planesrevdetalle: { estado1: @planesrevdetalle.estado1, estado2: @planesrevdetalle.estado2, estado3: @planesrevdetalle.estado3, idplanesrecaudo: @planesrevdetalle.idplanesrecaudo, planesreversion_id: @planesrevdetalle.planesreversion_id } }
    assert_redirected_to planesrevdetalle_url(@planesrevdetalle)
  end

  test "should destroy planesrevdetalle" do
    assert_difference('Planesrevdetalle.count', -1) do
      delete planesrevdetalle_url(@planesrevdetalle)
    end

    assert_redirected_to planesrevdetalles_url
  end
end
