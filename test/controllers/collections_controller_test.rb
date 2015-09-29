require 'test_helper'

class CollectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get properties" do
    get :properties
    assert_response :success
  end

end
