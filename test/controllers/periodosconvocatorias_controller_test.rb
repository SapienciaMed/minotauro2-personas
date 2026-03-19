require 'test_helper'

class PeriodosconvocatoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @periodosconvocatoria = periodosconvocatorias(:one)
  end

  test "should get index" do
    get periodosconvocatorias_url
    assert_response :success
  end

  test "should get new" do
    get new_periodosconvocatoria_url
    assert_response :success
  end

  test "should create periodosconvocatoria" do
    assert_difference('Periodosconvocatoria.count') do
      post periodosconvocatorias_url, params: { periodosconvocatoria: { activo: @periodosconvocatoria.activo, convocatoria: @periodosconvocatoria.convocatoria } }
    end

    assert_redirected_to periodosconvocatoria_url(Periodosconvocatoria.last)
  end

  test "should show periodosconvocatoria" do
    get periodosconvocatoria_url(@periodosconvocatoria)
    assert_response :success
  end

  test "should get edit" do
    get edit_periodosconvocatoria_url(@periodosconvocatoria)
    assert_response :success
  end

  test "should update periodosconvocatoria" do
    patch periodosconvocatoria_url(@periodosconvocatoria), params: { periodosconvocatoria: { activo: @periodosconvocatoria.activo, convocatoria: @periodosconvocatoria.convocatoria } }
    assert_redirected_to periodosconvocatoria_url(@periodosconvocatoria)
  end

  test "should destroy periodosconvocatoria" do
    assert_difference('Periodosconvocatoria.count', -1) do
      delete periodosconvocatoria_url(@periodosconvocatoria)
    end

    assert_redirected_to periodosconvocatorias_url
  end
end
