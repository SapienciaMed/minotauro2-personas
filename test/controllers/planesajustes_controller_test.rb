require 'test_helper'

class PlanesajustesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planesajuste = planesajustes(:one)
  end

  test "should get index" do
    get planesajustes_url
    assert_response :success
  end

  test "should get new" do
    get new_planesajuste_url
    assert_response :success
  end

  test "should create planesajuste" do
    assert_difference('Planesajuste.count') do
      post planesajustes_url, params: { planesajuste: { fecha: @planesajuste.fecha, observacion_anula: @planesajuste.observacion_anula, observaciones: @planesajuste.observaciones, personasobligacion_id: @planesajuste.personasobligacion_id, portafolio_id: @planesajuste.portafolio_id, user_anula: @planesajuste.user_anula, user_id: @planesajuste.user_id, valor: @planesajuste.valor } }
    end

    assert_redirected_to planesajuste_url(Planesajuste.last)
  end

  test "should show planesajuste" do
    get planesajuste_url(@planesajuste)
    assert_response :success
  end

  test "should get edit" do
    get edit_planesajuste_url(@planesajuste)
    assert_response :success
  end

  test "should update planesajuste" do
    patch planesajuste_url(@planesajuste), params: { planesajuste: { fecha: @planesajuste.fecha, observacion_anula: @planesajuste.observacion_anula, observaciones: @planesajuste.observaciones, personasobligacion_id: @planesajuste.personasobligacion_id, portafolio_id: @planesajuste.portafolio_id, user_anula: @planesajuste.user_anula, user_id: @planesajuste.user_id, valor: @planesajuste.valor } }
    assert_redirected_to planesajuste_url(@planesajuste)
  end

  test "should destroy planesajuste" do
    assert_difference('Planesajuste.count', -1) do
      delete planesajuste_url(@planesajuste)
    end

    assert_redirected_to planesajustes_url
  end
end
