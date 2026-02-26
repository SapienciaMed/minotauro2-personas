require "application_system_test_case"

class PersonaspropdireccionesTest < ApplicationSystemTestCase
  setup do
    @personaspropdireccion = personaspropdirecciones(:one)
  end

  test "visiting the index" do
    visit personaspropdirecciones_url
    assert_selector "h1", text: "Personaspropdirecciones"
  end

  test "creating a Personaspropdireccion" do
    visit personaspropdirecciones_url
    click_on "New Personaspropdireccion"

    fill_in "Persona", with: @personaspropdireccion.persona_id
    fill_in "Personasdireccion", with: @personaspropdireccion.personasdireccion_id
    fill_in "Personasproceso", with: @personaspropdireccion.personasproceso_id
    fill_in "Personaspropropietario", with: @personaspropdireccion.personaspropropietario_id
    click_on "Create Personaspropdireccion"

    assert_text "Personaspropdireccion was successfully created"
    click_on "Back"
  end

  test "updating a Personaspropdireccion" do
    visit personaspropdirecciones_url
    click_on "Edit", match: :first

    fill_in "Persona", with: @personaspropdireccion.persona_id
    fill_in "Personasdireccion", with: @personaspropdireccion.personasdireccion_id
    fill_in "Personasproceso", with: @personaspropdireccion.personasproceso_id
    fill_in "Personaspropropietario", with: @personaspropdireccion.personaspropropietario_id
    click_on "Update Personaspropdireccion"

    assert_text "Personaspropdireccion was successfully updated"
    click_on "Back"
  end

  test "destroying a Personaspropdireccion" do
    visit personaspropdirecciones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Personaspropdireccion was successfully destroyed"
  end
end
