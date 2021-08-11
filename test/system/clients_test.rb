require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "creating a Client" do
    visit clients_url
    click_on "New Client"

    fill_in "Address", with: @client.address
    fill_in "Country", with: @client.country
    fill_in "Email", with: @client.email
    fill_in "Endorsement address", with: @client.endorsement_address
    fill_in "Endorsement country", with: @client.endorsement_country
    fill_in "Endorsement full name", with: @client.endorsement_full_name
    fill_in "Endorsement location", with: @client.endorsement_location
    fill_in "Endorsement mobile phone", with: @client.endorsement_mobile_phone
    fill_in "Endorsement phone number", with: @client.endorsement_phone_number
    fill_in "Endorsement postal code", with: @client.endorsement_postal_code
    fill_in "Endorsement relationship", with: @client.endorsement_relationship
    fill_in "First surname", with: @client.first_surname
    fill_in "Location", with: @client.location
    fill_in "Mobile number", with: @client.mobile_number
    fill_in "Name", with: @client.name
    fill_in "Phone number", with: @client.phone_number
    fill_in "Postal code", with: @client.postal_code
    fill_in "Second surname", with: @client.second_surname
    fill_in "State", with: @client.state
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "updating a Client" do
    visit clients_url
    click_on "Edit", match: :first

    fill_in "Address", with: @client.address
    fill_in "Country", with: @client.country
    fill_in "Email", with: @client.email
    fill_in "Endorsement address", with: @client.endorsement_address
    fill_in "Endorsement country", with: @client.endorsement_country
    fill_in "Endorsement full name", with: @client.endorsement_full_name
    fill_in "Endorsement location", with: @client.endorsement_location
    fill_in "Endorsement mobile phone", with: @client.endorsement_mobile_phone
    fill_in "Endorsement phone number", with: @client.endorsement_phone_number
    fill_in "Endorsement postal code", with: @client.endorsement_postal_code
    fill_in "Endorsement relationship", with: @client.endorsement_relationship
    fill_in "First surname", with: @client.first_surname
    fill_in "Location", with: @client.location
    fill_in "Mobile number", with: @client.mobile_number
    fill_in "Name", with: @client.name
    fill_in "Phone number", with: @client.phone_number
    fill_in "Postal code", with: @client.postal_code
    fill_in "Second surname", with: @client.second_surname
    fill_in "State", with: @client.state
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "destroying a Client" do
    visit clients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client was successfully destroyed"
  end
end
