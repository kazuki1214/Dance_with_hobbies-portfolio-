require 'test_helper'

class EndUser::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_comments_index_url
    assert_response :success
  end

end
