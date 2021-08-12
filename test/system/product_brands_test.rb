require "application_system_test_case"

class ProductBrandsTest < ApplicationSystemTestCase
  setup do
    @product_brand = product_brands(:one)
  end

  test "visiting the index" do
    visit product_brands_url
    assert_selector "h1", text: "Product Brands"
  end

  test "creating a Product brand" do
    visit product_brands_url
    click_on "New Product Brand"

    check "Active" if @product_brand.active
    fill_in "Name", with: @product_brand.name
    click_on "Create Product brand"

    assert_text "Product brand was successfully created"
    click_on "Back"
  end

  test "updating a Product brand" do
    visit product_brands_url
    click_on "Edit", match: :first

    check "Active" if @product_brand.active
    fill_in "Name", with: @product_brand.name
    click_on "Update Product brand"

    assert_text "Product brand was successfully updated"
    click_on "Back"
  end

  test "destroying a Product brand" do
    visit product_brands_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product brand was successfully destroyed"
  end
end
