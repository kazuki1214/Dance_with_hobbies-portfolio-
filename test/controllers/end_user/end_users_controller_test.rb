require 'test_helper'

class EndUser::EndUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get end_user_end_users_new_url
    assert_response :success
  end

end
