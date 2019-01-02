require 'test_helper'

class HeartbeatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heartbeat = heartbeats(:one)
  end

  test "should get index" do
    get heartbeats_url
    assert_response :success
  end

  test "should get new" do
    get new_heartbeat_url
    assert_response :success
  end

  test "should create heartbeat" do
    assert_difference('Heartbeat.count') do
      post heartbeats_url, params: { heartbeat: { humid: @heartbeat.humid, sensor_id: @heartbeat.sensor_id, temp: @heartbeat.temp, voltage: @heartbeat.voltage } }
    end

    assert_redirected_to heartbeat_url(Heartbeat.last)
  end

  test "should show heartbeat" do
    get heartbeat_url(@heartbeat)
    assert_response :success
  end

  test "should get edit" do
    get edit_heartbeat_url(@heartbeat)
    assert_response :success
  end

  test "should update heartbeat" do
    patch heartbeat_url(@heartbeat), params: { heartbeat: { humid: @heartbeat.humid, sensor_id: @heartbeat.sensor_id, temp: @heartbeat.temp, voltage: @heartbeat.voltage } }
    assert_redirected_to heartbeat_url(@heartbeat)
  end

  test "should destroy heartbeat" do
    assert_difference('Heartbeat.count', -1) do
      delete heartbeat_url(@heartbeat)
    end

    assert_redirected_to heartbeats_url
  end
end
