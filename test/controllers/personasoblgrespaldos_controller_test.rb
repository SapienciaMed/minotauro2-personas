require 'test_helper'

class PersonasoblgrespaldosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personasoblgrespaldo = personasoblgrespaldos(:one)
  end

  test "should get index" do
    get personasoblgrespaldos_url
    assert_response :success
  end

  test "should get new" do
    get new_personasoblgrespaldo_url
    assert_response :success
  end

  test "should create personasoblgrespaldo" do
    assert_difference('Personasoblgrespaldo.count') do
      post personasoblgrespaldos_url, params: { personasoblgrespaldo: { _id: @personasoblgrespaldo._id, fecha: @personasoblgrespaldo.fecha, personasobligacion_id: @personasoblgrespaldo.personasobligacion_id, planesrecaudo_id: @personasoblgrespaldo.planesrecaudo_id, valor: @personasoblgrespaldo.valor, valor_original: @personasoblgrespaldo.valor_original } }
    end

    assert_redirected_to personasoblgrespaldo_url(Personasoblgrespaldo.last)
  end

  test "should show personasoblgrespaldo" do
    get personasoblgrespaldo_url(@personasoblgrespaldo)
    assert_response :success
  end

  test "should get edit" do
    get edit_personasoblgrespaldo_url(@personasoblgrespaldo)
    assert_response :success
  end

  test "should update personasoblgrespaldo" do
    patch personasoblgrespaldo_url(@personasoblgrespaldo), params: { personasoblgrespaldo: { _id: @personasoblgrespaldo._id, fecha: @personasoblgrespaldo.fecha, personasobligacion_id: @personasoblgrespaldo.personasobligacion_id, planesrecaudo_id: @personasoblgrespaldo.planesrecaudo_id, valor: @personasoblgrespaldo.valor, valor_original: @personasoblgrespaldo.valor_original } }
    assert_redirected_to personasoblgrespaldo_url(@personasoblgrespaldo)
  end

  test "should destroy personasoblgrespaldo" do
    assert_difference('Personasoblgrespaldo.count', -1) do
      delete personasoblgrespaldo_url(@personasoblgrespaldo)
    end

    assert_redirected_to personasoblgrespaldos_url
  end
end
