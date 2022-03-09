require 'test_helper'

class EndUsers::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_users_notifications_index_url
    assert_response :success
  end

end
