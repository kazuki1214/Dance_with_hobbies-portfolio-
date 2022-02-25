require 'test_helper'

class EndUser::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_categories_index_url
    assert_response :success
  end

end
