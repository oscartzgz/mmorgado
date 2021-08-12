require 'test_helper'

class ProductBrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_brand = product_brands(:one)
  end

  test "should get index" do
    get product_brands_url
    assert_response :success
  end

  test "should get new" do
    get new_product_brand_url
    assert_response :success
  end

  test "should create product_brand" do
    assert_difference('ProductBrand.count') do
      post product_brands_url, params: { product_brand: { active: @product_brand.active, name: @product_brand.name } }
    end

    assert_redirected_to product_brand_url(ProductBrand.last)
  end

  test "should show product_brand" do
    get product_brand_url(@product_brand)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_brand_url(@product_brand)
    assert_response :success
  end

  test "should update product_brand" do
    patch product_brand_url(@product_brand), params: { product_brand: { active: @product_brand.active, name: @product_brand.name } }
    assert_redirected_to product_brand_url(@product_brand)
  end

  test "should destroy product_brand" do
    assert_difference('ProductBrand.count', -1) do
      delete product_brand_url(@product_brand)
    end

    assert_redirected_to product_brands_url
  end
end
