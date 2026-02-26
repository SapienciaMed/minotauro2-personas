require 'test_helper'

class TiposestratosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposestrato = tiposestratos(:one)
  end

  test "should get index" do
    get tiposestratos_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposestrato_url
    assert_response :success
  end

  test "should create tiposestrato" do
    assert_difference('Tiposestrato.count') do
      post tiposestratos_url, params: { tiposestrato: { descripcion: @tiposestrato.descripcion, numero: @tiposestrato.numero } }
    end

    assert_redirected_to tiposestrato_url(Tiposestrato.last)
  end

  test "should show tiposestrato" do
    get tiposestrato_url(@tiposestrato)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposestrato_url(@tiposestrato)
    assert_response :success
  end

  test "should update tiposestrato" do
    patch tiposestrato_url(@tiposestrato), params: { tiposestrato: { descripcion: @tiposestrato.descripcion, numero: @tiposestrato.numero } }
    assert_redirected_to tiposestrato_url(@tiposestrato)
  end

  test "should destroy tiposestrato" do
    assert_difference('Tiposestrato.count', -1) do
      delete tiposestrato_url(@tiposestrato)
    end

    assert_redirected_to tiposestratos_url
  end
end
