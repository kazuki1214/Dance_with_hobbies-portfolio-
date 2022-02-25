require 'test_helper'

class EndUser::PostHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_post_histories_index_url
    assert_response :success
  end

  test "should get show" do
    get end_user_post_histories_show_url
    assert_response :success
  end

end
