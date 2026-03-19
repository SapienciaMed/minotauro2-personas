require 'test_helper'

class TiposunidadnegociosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposunidadnegocio = tiposunidadnegocios(:one)
  end

  test "should get index" do
    get tiposunidadnegocios_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposunidadnegocio_url
    assert_response :success
  end

  test "should create tiposunidadnegocio" do
    assert_difference('Tiposunidadnegocio.count') do
      post tiposunidadnegocios_url, params: { tiposunidadnegocio: { descripcion: @tiposunidadnegocio.descripcion, portafolio_id: @tiposunidadnegocio.portafolio_id, user_act: @tiposunidadnegocio.user_act, user_id: @tiposunidadnegocio.user_id } }
    end

    assert_redirected_to tiposunidadnegocio_url(Tiposunidadnegocio.last)
  end

  test "should show tiposunidadnegocio" do
    get tiposunidadnegocio_url(@tiposunidadnegocio)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposunidadnegocio_url(@tiposunidadnegocio)
    assert_response :success
  end

  test "should update tiposunidadnegocio" do
    patch tiposunidadnegocio_url(@tiposunidadnegocio), params: { tiposunidadnegocio: { descripcion: @tiposunidadnegocio.descripcion, portafolio_id: @tiposunidadnegocio.portafolio_id, user_act: @tiposunidadnegocio.user_act, user_id: @tiposunidadnegocio.user_id } }
    assert_redirected_to tiposunidadnegocio_url(@tiposunidadnegocio)
  end

  test "should destroy tiposunidadnegocio" do
    assert_difference('Tiposunidadnegocio.count', -1) do
      delete tiposunidadnegocio_url(@tiposunidadnegocio)
    end

    assert_redirected_to tiposunidadnegocios_url
  end
end
