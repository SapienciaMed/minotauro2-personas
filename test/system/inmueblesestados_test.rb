require "application_system_test_case"

class InmueblesestadosTest < ApplicationSystemTestCase
  setup do
    @inmueblesestado = inmueblesestados(:one)
  end

  test "visiting the index" do
    visit inmueblesestados_url
    assert_selector "h1", text: "Inmueblesestados"
  end

  test "creating a Inmueblesestado" do
    visit inmueblesestados_url
    click_on "New Inmueblesestado"

    fill_in "Estado", with: @inmueblesestado.estado
    fill_in "Fecha", with: @inmueblesestado.fecha
    fill_in "Grupo", with: @inmueblesestado.grupo
    fill_in "Inmueble", with: @inmueblesestado.inmueble_id
    fill_in "Portafolio", with: @inmueblesestado.portafolio_id
    fill_in "User", with: @inmueblesestado.user_id
    click_on "Create Inmueblesestado"

    assert_text "Inmueblesestado was successfully created"
    click_on "Back"
  end

  test "updating a Inmueblesestado" do
    visit inmueblesestados_url
    click_on "Edit", match: :first

    fill_in "Estado", with: @inmueblesestado.estado
    fill_in "Fecha", with: @inmueblesestado.fecha
    fill_in "Grupo", with: @inmueblesestado.grupo
    fill_in "Inmueble", with: @inmueblesestado.inmueble_id
    fill_in "Portafolio", with: @inmueblesestado.portafolio_id
    fill_in "User", with: @inmueblesestado.user_id
    click_on "Update Inmueblesestado"

    assert_text "Inmueblesestado was successfully updated"
    click_on "Back"
  end

  test "destroying a Inmueblesestado" do
    visit inmueblesestados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inmueblesestado was successfully destroyed"
  end
end
