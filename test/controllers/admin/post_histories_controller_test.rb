require 'test_helper'

class Admin::PostHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_histories_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_histories_show_url
    assert_response :success
  end

end
