require 'test_helper'

class EndUser::FavoriteHobbiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_favorite_hobbies_index_url
    assert_response :success
  end

end
