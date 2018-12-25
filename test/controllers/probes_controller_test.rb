require 'test_helper'

class ProbesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @probe = probes(:one)
  end

  test "should get index" do
    get probes_url
    assert_response :success
  end

  test "should get new" do
    get new_probe_url
    assert_response :success
  end

  test "should create probe" do
    assert_difference('Probe.count') do
      post probes_url, params: { probe: { name: @probe.name, secret: @probe.secret } }
    end

    assert_redirected_to probe_url(Probe.last)
  end

  test "should show probe" do
    get probe_url(@probe)
    assert_response :success
  end

  test "should get edit" do
    get edit_probe_url(@probe)
    assert_response :success
  end

  test "should update probe" do
    patch probe_url(@probe), params: { probe: { name: @probe.name, secret: @probe.secret } }
    assert_redirected_to probe_url(@probe)
  end

  test "should destroy probe" do
    assert_difference('Probe.count', -1) do
      delete probe_url(@probe)
    end

    assert_redirected_to probes_url
  end
end
