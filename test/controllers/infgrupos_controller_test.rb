require 'test_helper'

class InfgruposControllerTest < ActionDispatch::IntegrationTest
  setup do
    @infgrupo = infgrupos(:one)
  end

  test "should get index" do
    get infgrupos_url
    assert_response :success
  end

  test "should get new" do
    get new_infgrupo_url
    assert_response :success
  end

  test "should create infgrupo" do
    assert_difference('Infgrupo.count') do
      post infgrupos_url, params: { infgrupo: { clase: @infgrupo.clase, consulta: @infgrupo.consulta, estado: @infgrupo.estado, nombre: @infgrupo.nombre, nombre_archivo: @infgrupo.nombre_archivo } }
    end

    assert_redirected_to infgrupo_url(Infgrupo.last)
  end

  test "should show infgrupo" do
    get infgrupo_url(@infgrupo)
    assert_response :success
  end

  test "should get edit" do
    get edit_infgrupo_url(@infgrupo)
    assert_response :success
  end

  test "should update infgrupo" do
    patch infgrupo_url(@infgrupo), params: { infgrupo: { clase: @infgrupo.clase, consulta: @infgrupo.consulta, estado: @infgrupo.estado, nombre: @infgrupo.nombre, nombre_archivo: @infgrupo.nombre_archivo } }
    assert_redirected_to infgrupo_url(@infgrupo)
  end

  test "should destroy infgrupo" do
    assert_difference('Infgrupo.count', -1) do
      delete infgrupo_url(@infgrupo)
    end

    assert_redirected_to infgrupos_url
  end
end
