require 'test_helper'

class MessageSourceControllerTest < ActionController::TestCase
  test "should get directory" do
    get :directory
    assert_response :success
  end

end
