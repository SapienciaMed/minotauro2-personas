require 'test_helper'

class LineacreditosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lineacredito = lineacreditos(:one)
  end

  test "should get index" do
    get lineacreditos_url
    assert_response :success
  end

  test "should get new" do
    get new_lineacredito_url
    assert_response :success
  end

  test "should create lineacredito" do
    assert_difference('Lineacredito.count') do
      post lineacreditos_url, params: { lineacredito: { descripcion: @lineacredito.descripcion } }
    end

    assert_redirected_to lineacredito_url(Lineacredito.last)
  end

  test "should show lineacredito" do
    get lineacredito_url(@lineacredito)
    assert_response :success
  end

  test "should get edit" do
    get edit_lineacredito_url(@lineacredito)
    assert_response :success
  end

  test "should update lineacredito" do
    patch lineacredito_url(@lineacredito), params: { lineacredito: { descripcion: @lineacredito.descripcion } }
    assert_redirected_to lineacredito_url(@lineacredito)
  end

  test "should destroy lineacredito" do
    assert_difference('Lineacredito.count', -1) do
      delete lineacredito_url(@lineacredito)
    end

    assert_redirected_to lineacreditos_url
  end
end
