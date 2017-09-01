require 'test_helper'

class MeusProjetosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get meus_projetos_new_url
    assert_response :success
  end

  test "should get view" do
    get meus_projetos_view_url
    assert_response :success
  end

end
