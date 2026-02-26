require 'test_helper'

class PeriodosconvrelacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @periodosconvrelacion = periodosconvrelaciones(:one)
  end

  test "should get index" do
    get periodosconvrelaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_periodosconvrelacion_url
    assert_response :success
  end

  test "should create periodosconvrelacion" do
    assert_difference('Periodosconvrelacion.count') do
      post periodosconvrelaciones_url, params: { periodosconvrelacion: { periodoanterior_id: @periodosconvrelacion.periodoanterior_id, periodosconvocatoria_id: @periodosconvrelacion.periodosconvocatoria_id, portafolio_id: @periodosconvrelacion.portafolio_id } }
    end

    assert_redirected_to periodosconvrelacion_url(Periodosconvrelacion.last)
  end

  test "should show periodosconvrelacion" do
    get periodosconvrelacion_url(@periodosconvrelacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_periodosconvrelacion_url(@periodosconvrelacion)
    assert_response :success
  end

  test "should update periodosconvrelacion" do
    patch periodosconvrelacion_url(@periodosconvrelacion), params: { periodosconvrelacion: { periodoanterior_id: @periodosconvrelacion.periodoanterior_id, periodosconvocatoria_id: @periodosconvrelacion.periodosconvocatoria_id, portafolio_id: @periodosconvrelacion.portafolio_id } }
    assert_redirected_to periodosconvrelacion_url(@periodosconvrelacion)
  end

  test "should destroy periodosconvrelacion" do
    assert_difference('Periodosconvrelacion.count', -1) do
      delete periodosconvrelacion_url(@periodosconvrelacion)
    end

    assert_redirected_to periodosconvrelaciones_url
  end
end
