require 'test_helper'

class PecuniariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pecuniario = pecuniarios(:one)
  end

  test "should get index" do
    get pecuniarios_url
    assert_response :success
  end

  test "should get new" do
    get new_pecuniario_url
    assert_response :success
  end

  test "should create pecuniario" do
    assert_difference('Pecuniario.count') do
      post pecuniarios_url, params: { pecuniario: { descripcion: @pecuniario.descripcion, nombre: @pecuniario.nombre } }
    end

    assert_redirected_to pecuniario_url(Pecuniario.last)
  end

  test "should show pecuniario" do
    get pecuniario_url(@pecuniario)
    assert_response :success
  end

  test "should get edit" do
    get edit_pecuniario_url(@pecuniario)
    assert_response :success
  end

  test "should update pecuniario" do
    patch pecuniario_url(@pecuniario), params: { pecuniario: { descripcion: @pecuniario.descripcion, nombre: @pecuniario.nombre } }
    assert_redirected_to pecuniario_url(@pecuniario)
  end

  test "should destroy pecuniario" do
    assert_difference('Pecuniario.count', -1) do
      delete pecuniario_url(@pecuniario)
    end

    assert_redirected_to pecuniarios_url
  end
end
