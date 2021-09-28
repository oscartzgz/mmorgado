require "test_helper"

class Api::V1::ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_clients_index_url
    assert_response :success
  end
end
