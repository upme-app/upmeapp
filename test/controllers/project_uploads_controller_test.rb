require 'test_helper'

class ProjectUploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_uploads_index_url
    assert_response :success
  end

end
