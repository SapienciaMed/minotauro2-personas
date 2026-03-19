require 'test_helper'

class PlaneshobligacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planeshobligacion = planeshobligaciones(:one)
  end

  test "should get index" do
    get planeshobligaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_planeshobligacion_url
    assert_response :success
  end

  test "should create planeshobligacion" do
    assert_difference('Planeshobligacion.count') do
      post planeshobligaciones_url, params: { planeshobligacion: { amortiza: @planeshobligacion.amortiza, comp: @planeshobligacion.comp, comp_pend: @planeshobligacion.comp_pend, corriente: @planeshobligacion.corriente, cuota: @planeshobligacion.cuota, fecha_inicio: @planeshobligacion.fecha_inicio, fecha_limitei: @planeshobligacion.fecha_limitei, fecha_pago: @planeshobligacion.fecha_pago, fecha_vence: @planeshobligacion.fecha_vence, fechadepago: @planeshobligacion.fechadepago, final: @planeshobligacion.final, igv: @planeshobligacion.igv, igv_comp: @planeshobligacion.igv_comp, igv_comp_pend: @planeshobligacion.igv_comp_pend, inicial: @planeshobligacion.inicial, mora: @planeshobligacion.mora, morapendiente: @planeshobligacion.morapendiente, nro_cuota: @planeshobligacion.nro_cuota, otros: @planeshobligacion.otros, persona_id: @planeshobligacion.persona_id, personasobligacion_id: @planeshobligacion.personasobligacion_id, valor_pagar: @planeshobligacion.valor_pagar, valor_porte: @planeshobligacion.valor_porte, valor_seguro2: @planeshobligacion.valor_seguro2, valor_seguro2acum: @planeshobligacion.valor_seguro2acum, valor_seguro3: @planeshobligacion.valor_seguro3, valor_seguro3acum: @planeshobligacion.valor_seguro3acum, valor_seguro: @planeshobligacion.valor_seguro, valor_seguroacum: @planeshobligacion.valor_seguroacum } }
    end

    assert_redirected_to planeshobligacion_url(Planeshobligacion.last)
  end

  test "should show planeshobligacion" do
    get planeshobligacion_url(@planeshobligacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_planeshobligacion_url(@planeshobligacion)
    assert_response :success
  end

  test "should update planeshobligacion" do
    patch planeshobligacion_url(@planeshobligacion), params: { planeshobligacion: { amortiza: @planeshobligacion.amortiza, comp: @planeshobligacion.comp, comp_pend: @planeshobligacion.comp_pend, corriente: @planeshobligacion.corriente, cuota: @planeshobligacion.cuota, fecha_inicio: @planeshobligacion.fecha_inicio, fecha_limitei: @planeshobligacion.fecha_limitei, fecha_pago: @planeshobligacion.fecha_pago, fecha_vence: @planeshobligacion.fecha_vence, fechadepago: @planeshobligacion.fechadepago, final: @planeshobligacion.final, igv: @planeshobligacion.igv, igv_comp: @planeshobligacion.igv_comp, igv_comp_pend: @planeshobligacion.igv_comp_pend, inicial: @planeshobligacion.inicial, mora: @planeshobligacion.mora, morapendiente: @planeshobligacion.morapendiente, nro_cuota: @planeshobligacion.nro_cuota, otros: @planeshobligacion.otros, persona_id: @planeshobligacion.persona_id, personasobligacion_id: @planeshobligacion.personasobligacion_id, valor_pagar: @planeshobligacion.valor_pagar, valor_porte: @planeshobligacion.valor_porte, valor_seguro2: @planeshobligacion.valor_seguro2, valor_seguro2acum: @planeshobligacion.valor_seguro2acum, valor_seguro3: @planeshobligacion.valor_seguro3, valor_seguro3acum: @planeshobligacion.valor_seguro3acum, valor_seguro: @planeshobligacion.valor_seguro, valor_seguroacum: @planeshobligacion.valor_seguroacum } }
    assert_redirected_to planeshobligacion_url(@planeshobligacion)
  end

  test "should destroy planeshobligacion" do
    assert_difference('Planeshobligacion.count', -1) do
      delete planeshobligacion_url(@planeshobligacion)
    end

    assert_redirected_to planeshobligaciones_url
  end
end
