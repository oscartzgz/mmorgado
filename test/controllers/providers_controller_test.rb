require 'test_helper'

class ProvidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @provider = providers(:one)
  end

  test "should get index" do
    get providers_url
    assert_response :success
  end

  test "should get new" do
    get new_provider_url
    assert_response :success
  end

  test "should create provider" do
    assert_difference('Provider.count') do
      post providers_url, params: { provider: { address: @provider.address, city: @provider.city, contact_email: @provider.contact_email, contact_full_name: @provider.contact_full_name, contact_mobile_number: @provider.contact_mobile_number, contact_phone_number: @provider.contact_phone_number, country: @provider.country, full_name: @provider.full_name, phone_number: @provider.phone_number, postal_code: @provider.postal_code } }
    end

    assert_redirected_to provider_url(Provider.last)
  end

  test "should show provider" do
    get provider_url(@provider)
    assert_response :success
  end

  test "should get edit" do
    get edit_provider_url(@provider)
    assert_response :success
  end

  test "should update provider" do
    patch provider_url(@provider), params: { provider: { address: @provider.address, city: @provider.city, contact_email: @provider.contact_email, contact_full_name: @provider.contact_full_name, contact_mobile_number: @provider.contact_mobile_number, contact_phone_number: @provider.contact_phone_number, country: @provider.country, full_name: @provider.full_name, phone_number: @provider.phone_number, postal_code: @provider.postal_code } }
    assert_redirected_to provider_url(@provider)
  end

  test "should destroy provider" do
    assert_difference('Provider.count', -1) do
      delete provider_url(@provider)
    end

    assert_redirected_to providers_url
  end
end
