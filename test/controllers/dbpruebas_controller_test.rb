require 'test_helper'

class DbpruebasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dbprueba = dbpruebas(:one)
  end

  test "should get index" do
    get dbpruebas_url
    assert_response :success
  end

  test "should get new" do
    get new_dbprueba_url
    assert_response :success
  end

  test "should create dbprueba" do
    assert_difference('Dbprueba.count') do
      post dbpruebas_url, params: { dbprueba: { nombre: @dbprueba.nombre } }
    end

    assert_redirected_to dbprueba_url(Dbprueba.last)
  end

  test "should show dbprueba" do
    get dbprueba_url(@dbprueba)
    assert_response :success
  end

  test "should get edit" do
    get edit_dbprueba_url(@dbprueba)
    assert_response :success
  end

  test "should update dbprueba" do
    patch dbprueba_url(@dbprueba), params: { dbprueba: { nombre: @dbprueba.nombre } }
    assert_redirected_to dbprueba_url(@dbprueba)
  end

  test "should destroy dbprueba" do
    assert_difference('Dbprueba.count', -1) do
      delete dbprueba_url(@dbprueba)
    end

    assert_redirected_to dbpruebas_url
  end
end
