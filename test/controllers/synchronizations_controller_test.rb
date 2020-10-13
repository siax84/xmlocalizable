require 'test_helper'

class SynchronizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @synchronization = synchronizations(:one)
  end

  test "should get index" do
    get synchronizations_url
    assert_response :success
  end

  test "should get new" do
    get new_synchronization_url
    assert_response :success
  end

  test "should create synchronization" do
    assert_difference('Synchronization.count') do
      post synchronizations_url, params: { synchronization: { name: @synchronization.name } }
    end

    assert_redirected_to synchronization_url(Synchronization.last)
  end

  test "should show synchronization" do
    get synchronization_url(@synchronization)
    assert_response :success
  end

  test "should get edit" do
    get edit_synchronization_url(@synchronization)
    assert_response :success
  end

  test "should update synchronization" do
    patch synchronization_url(@synchronization), params: { synchronization: { name: @synchronization.name } }
    assert_redirected_to synchronization_url(@synchronization)
  end

  test "should destroy synchronization" do
    assert_difference('Synchronization.count', -1) do
      delete synchronization_url(@synchronization)
    end

    assert_redirected_to synchronizations_url
  end
end
