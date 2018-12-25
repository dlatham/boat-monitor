require "application_system_test_case"

class BilgesTest < ApplicationSystemTestCase
  setup do
    @bilge = bilges(:one)
  end

  test "visiting the index" do
    visit bilges_url
    assert_selector "h1", text: "Bilges"
  end

  test "creating a Bilge" do
    visit bilges_url
    click_on "New Bilge"

    fill_in "Duration", with: @bilge.duration
    fill_in "Id", with: @bilge.id
    click_on "Create Bilge"

    assert_text "Bilge was successfully created"
    click_on "Back"
  end

  test "updating a Bilge" do
    visit bilges_url
    click_on "Edit", match: :first

    fill_in "Duration", with: @bilge.duration
    fill_in "Id", with: @bilge.id
    click_on "Update Bilge"

    assert_text "Bilge was successfully updated"
    click_on "Back"
  end

  test "destroying a Bilge" do
    visit bilges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bilge was successfully destroyed"
  end
end
