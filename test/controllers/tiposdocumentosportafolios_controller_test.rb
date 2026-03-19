require 'test_helper'

class TiposdocumentosportafoliosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposdocumentosportafolio = tiposdocumentosportafolios(:one)
  end

  test "should get index" do
    get tiposdocumentosportafolios_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposdocumentosportafolio_url
    assert_response :success
  end

  test "should create tiposdocumentosportafolio" do
    assert_difference('Tiposdocumentosportafolio.count') do
      post tiposdocumentosportafolios_url, params: { tiposdocumentosportafolio: { portafolio_id: @tiposdocumentosportafolio.portafolio_id } }
    end

    assert_redirected_to tiposdocumentosportafolio_url(Tiposdocumentosportafolio.last)
  end

  test "should show tiposdocumentosportafolio" do
    get tiposdocumentosportafolio_url(@tiposdocumentosportafolio)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposdocumentosportafolio_url(@tiposdocumentosportafolio)
    assert_response :success
  end

  test "should update tiposdocumentosportafolio" do
    patch tiposdocumentosportafolio_url(@tiposdocumentosportafolio), params: { tiposdocumentosportafolio: { portafolio_id: @tiposdocumentosportafolio.portafolio_id } }
    assert_redirected_to tiposdocumentosportafolio_url(@tiposdocumentosportafolio)
  end

  test "should destroy tiposdocumentosportafolio" do
    assert_difference('Tiposdocumentosportafolio.count', -1) do
      delete tiposdocumentosportafolio_url(@tiposdocumentosportafolio)
    end

    assert_redirected_to tiposdocumentosportafolios_url
  end
end
