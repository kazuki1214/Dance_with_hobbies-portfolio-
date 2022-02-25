require 'test_helper'

class EndUser::FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_followers_index_url
    assert_response :success
  end

end
