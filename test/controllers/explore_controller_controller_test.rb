require 'test_helper'

class ExploreControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get explore_controller_index_url
    assert_response :success
  end

end
