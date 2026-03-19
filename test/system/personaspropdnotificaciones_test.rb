require "application_system_test_case"

class PersonaspropdnotificacionesTest < ApplicationSystemTestCase
  setup do
    @personaspropdnotificacion = personaspropdnotificaciones(:one)
  end

  test "visiting the index" do
    visit personaspropdnotificaciones_url
    assert_selector "h1", text: "Personaspropdnotificaciones"
  end

  test "creating a Personaspropdnotificacion" do
    visit personaspropdnotificaciones_url
    click_on "New Personaspropdnotificacion"

    fill_in "Fecha", with: @personaspropdnotificacion.fecha
    fill_in "Observacion", with: @personaspropdnotificacion.observacion
    fill_in "Personaspropdireccion", with: @personaspropdnotificacion.personaspropdireccion_id
    fill_in "Procesosactuacion", with: @personaspropdnotificacion.procesosactuacion_id
    fill_in "Procesosetapa", with: @personaspropdnotificacion.procesosetapa_id
    fill_in "Resultado", with: @personaspropdnotificacion.resultado
    fill_in "User", with: @personaspropdnotificacion.user_id
    click_on "Create Personaspropdnotificacion"

    assert_text "Personaspropdnotificacion was successfully created"
    click_on "Back"
  end

  test "updating a Personaspropdnotificacion" do
    visit personaspropdnotificaciones_url
    click_on "Edit", match: :first

    fill_in "Fecha", with: @personaspropdnotificacion.fecha
    fill_in "Observacion", with: @personaspropdnotificacion.observacion
    fill_in "Personaspropdireccion", with: @personaspropdnotificacion.personaspropdireccion_id
    fill_in "Procesosactuacion", with: @personaspropdnotificacion.procesosactuacion_id
    fill_in "Procesosetapa", with: @personaspropdnotificacion.procesosetapa_id
    fill_in "Resultado", with: @personaspropdnotificacion.resultado
    fill_in "User", with: @personaspropdnotificacion.user_id
    click_on "Update Personaspropdnotificacion"

    assert_text "Personaspropdnotificacion was successfully updated"
    click_on "Back"
  end

  test "destroying a Personaspropdnotificacion" do
    visit personaspropdnotificaciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Personaspropdnotificacion was successfully destroyed"
  end
end
