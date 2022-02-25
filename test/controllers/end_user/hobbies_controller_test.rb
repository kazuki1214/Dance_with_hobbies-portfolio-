require 'test_helper'

class EndUser::HobbiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_hobbies_index_url
    assert_response :success
  end

  test "should get show" do
    get end_user_hobbies_show_url
    assert_response :success
  end

end
