require 'test_helper'

class ModalidadescontratosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @modalidadescontrato = modalidadescontratos(:one)
  end

  test "should get index" do
    get modalidadescontratos_url
    assert_response :success
  end

  test "should get new" do
    get new_modalidadescontrato_url
    assert_response :success
  end

  test "should create modalidadescontrato" do
    assert_difference('Modalidadescontrato.count') do
      post modalidadescontratos_url, params: { modalidadescontrato: { descripcion: @modalidadescontrato.descripcion, portafolio_id: @modalidadescontrato.portafolio_id, portafolioscontrato_id: @modalidadescontrato.portafolioscontrato_id, user_act: @modalidadescontrato.user_act, user_id: @modalidadescontrato.user_id } }
    end

    assert_redirected_to modalidadescontrato_url(Modalidadescontrato.last)
  end

  test "should show modalidadescontrato" do
    get modalidadescontrato_url(@modalidadescontrato)
    assert_response :success
  end

  test "should get edit" do
    get edit_modalidadescontrato_url(@modalidadescontrato)
    assert_response :success
  end

  test "should update modalidadescontrato" do
    patch modalidadescontrato_url(@modalidadescontrato), params: { modalidadescontrato: { descripcion: @modalidadescontrato.descripcion, portafolio_id: @modalidadescontrato.portafolio_id, portafolioscontrato_id: @modalidadescontrato.portafolioscontrato_id, user_act: @modalidadescontrato.user_act, user_id: @modalidadescontrato.user_id } }
    assert_redirected_to modalidadescontrato_url(@modalidadescontrato)
  end

  test "should destroy modalidadescontrato" do
    assert_difference('Modalidadescontrato.count', -1) do
      delete modalidadescontrato_url(@modalidadescontrato)
    end

    assert_redirected_to modalidadescontratos_url
  end
end
