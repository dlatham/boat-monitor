require 'test_helper'

class BilgesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bilge = bilges(:one)
  end

  test "should get index" do
    get bilges_url
    assert_response :success
  end

  test "should get new" do
    get new_bilge_url
    assert_response :success
  end

  test "should create bilge" do
    assert_difference('Bilge.count') do
      post bilges_url, params: { bilge: { duration: @bilge.duration, id: @bilge.id } }
    end

    assert_redirected_to bilge_url(Bilge.last)
  end

  test "should show bilge" do
    get bilge_url(@bilge)
    assert_response :success
  end

  test "should @signed_request = ApiAuth.sign!(@request, @probe_id, @secret_key)
  response = @signed_request.execute()get edit" do
    get edit_bilge_url(@bilge)
    assert_response :success
  end

  test "should update bilge" do
    patch bilge_url(@bilge), params: { bilge: { duration: @bilge.duration, id: @bilge.id } }
    assert_redirected_to bilge_url(@bilge)
  end

  test "should destroy bilge" do
    assert_difference('Bilge.count', -1) do
      delete bilge_url(@bilge)
    end

    assert_redirected_to bilges_url
  end

end
