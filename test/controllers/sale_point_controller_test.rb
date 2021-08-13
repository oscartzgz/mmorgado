require 'test_helper'

class SalePointControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sale_point_index_url
    assert_response :success
  end

end
