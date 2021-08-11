require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get clients_url
    assert_response :success
  end

  test "should get new" do
    get new_client_url
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post clients_url, params: { client: { address: @client.address, country: @client.country, email: @client.email, endorsement_address: @client.endorsement_address, endorsement_country: @client.endorsement_country, endorsement_full_name: @client.endorsement_full_name, endorsement_location: @client.endorsement_location, endorsement_mobile_phone: @client.endorsement_mobile_phone, endorsement_phone_number: @client.endorsement_phone_number, endorsement_postal_code: @client.endorsement_postal_code, endorsement_relationship: @client.endorsement_relationship, first_surname: @client.first_surname, location: @client.location, mobile_number: @client.mobile_number, name: @client.name, phone_number: @client.phone_number, postal_code: @client.postal_code, second_surname: @client.second_surname, state: @client.state } }
    end

    assert_redirected_to client_url(Client.last)
  end

  test "should show client" do
    get client_url(@client)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_url(@client)
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: { client: { address: @client.address, country: @client.country, email: @client.email, endorsement_address: @client.endorsement_address, endorsement_country: @client.endorsement_country, endorsement_full_name: @client.endorsement_full_name, endorsement_location: @client.endorsement_location, endorsement_mobile_phone: @client.endorsement_mobile_phone, endorsement_phone_number: @client.endorsement_phone_number, endorsement_postal_code: @client.endorsement_postal_code, endorsement_relationship: @client.endorsement_relationship, first_surname: @client.first_surname, location: @client.location, mobile_number: @client.mobile_number, name: @client.name, phone_number: @client.phone_number, postal_code: @client.postal_code, second_surname: @client.second_surname, state: @client.state } }
    assert_redirected_to client_url(@client)
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete client_url(@client)
    end

    assert_redirected_to clients_url
  end
end
