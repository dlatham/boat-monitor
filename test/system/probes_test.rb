require "application_system_test_case"

class ProbesTest < ApplicationSystemTestCase
  setup do
    @probe = probes(:one)
  end

  test "visiting the index" do
    visit probes_url
    assert_selector "h1", text: "Probes"
  end

  test "creating a Probe" do
    visit probes_url
    click_on "New Probe"

    fill_in "Name", with: @probe.name
    fill_in "Secret", with: @probe.secret
    click_on "Create Probe"

    assert_text "Probe was successfully created"
    click_on "Back"
  end

  test "updating a Probe" do
    visit probes_url
    click_on "Edit", match: :first

    fill_in "Name", with: @probe.name
    fill_in "Secret", with: @probe.secret
    click_on "Update Probe"

    assert_text "Probe was successfully updated"
    click_on "Back"
  end

  test "destroying a Probe" do
    visit probes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Probe was successfully destroyed"
  end
end
