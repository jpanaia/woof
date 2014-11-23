require 'test_helper'

class EpicenterControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_user" do
    get :show_user
    assert_response :success
  end

end
