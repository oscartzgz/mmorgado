require "test_helper"

class Providers::PurchasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get providers_purchases_index_url
    assert_response :success
  end
end
