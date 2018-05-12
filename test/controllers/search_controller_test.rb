require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get check_availbility" do
    get :check_availbility
    assert_response :success
  end

end
