require "test_helper"

class EditHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get edit_histories_index_url
    assert_response :success
  end
end
