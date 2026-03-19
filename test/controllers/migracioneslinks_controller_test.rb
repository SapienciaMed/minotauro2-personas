require 'test_helper'

class MigracioneslinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @migracioneslink = migracioneslinks(:one)
  end

  test "should get index" do
    get migracioneslinks_url
    assert_response :success
  end

  test "should get new" do
    get new_migracioneslink_url
    assert_response :success
  end

  test "should create migracioneslink" do
    assert_difference('Migracioneslink.count') do
      post migracioneslinks_url, params: { migracioneslink: { archivo_id: @migracioneslink.archivo_id, consecutivo: @migracioneslink.consecutivo, error: @migracioneslink.error, estado: @migracioneslink.estado, identificacion: @migracioneslink.identificacion, mensaje: @migracioneslink.mensaje, nro_obligacion: @migracioneslink.nro_obligacion, persona_id: @migracioneslink.persona_id, personasobligacion_id: @migracioneslink.personasobligacion_id, user_id: @migracioneslink.user_id, valor: @migracioneslink.valor } }
    end

    assert_redirected_to migracioneslink_url(Migracioneslink.last)
  end

  test "should show migracioneslink" do
    get migracioneslink_url(@migracioneslink)
    assert_response :success
  end

  test "should get edit" do
    get edit_migracioneslink_url(@migracioneslink)
    assert_response :success
  end

  test "should update migracioneslink" do
    patch migracioneslink_url(@migracioneslink), params: { migracioneslink: { archivo_id: @migracioneslink.archivo_id, consecutivo: @migracioneslink.consecutivo, error: @migracioneslink.error, estado: @migracioneslink.estado, identificacion: @migracioneslink.identificacion, mensaje: @migracioneslink.mensaje, nro_obligacion: @migracioneslink.nro_obligacion, persona_id: @migracioneslink.persona_id, personasobligacion_id: @migracioneslink.personasobligacion_id, user_id: @migracioneslink.user_id, valor: @migracioneslink.valor } }
    assert_redirected_to migracioneslink_url(@migracioneslink)
  end

  test "should destroy migracioneslink" do
    assert_difference('Migracioneslink.count', -1) do
      delete migracioneslink_url(@migracioneslink)
    end

    assert_redirected_to migracioneslinks_url
  end
end
