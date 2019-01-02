require "application_system_test_case"

class HeartbeatsTest < ApplicationSystemTestCase
  setup do
    @heartbeat = heartbeats(:one)
  end

  test "visiting the index" do
    visit heartbeats_url
    assert_selector "h1", text: "Heartbeats"
  end

  test "creating a Heartbeat" do
    visit heartbeats_url
    click_on "New Heartbeat"

    fill_in "Humid", with: @heartbeat.humid
    fill_in "Sensor", with: @heartbeat.sensor_id
    fill_in "Temp", with: @heartbeat.temp
    fill_in "Voltage", with: @heartbeat.voltage
    click_on "Create Heartbeat"

    assert_text "Heartbeat was successfully created"
    click_on "Back"
  end

  test "updating a Heartbeat" do
    visit heartbeats_url
    click_on "Edit", match: :first

    fill_in "Humid", with: @heartbeat.humid
    fill_in "Sensor", with: @heartbeat.sensor_id
    fill_in "Temp", with: @heartbeat.temp
    fill_in "Voltage", with: @heartbeat.voltage
    click_on "Update Heartbeat"

    assert_text "Heartbeat was successfully updated"
    click_on "Back"
  end

  test "destroying a Heartbeat" do
    visit heartbeats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Heartbeat was successfully destroyed"
  end
end
