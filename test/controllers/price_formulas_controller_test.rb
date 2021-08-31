require 'test_helper'

class PriceFormulasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @price_formula = price_formulas(:one)
  end

  test "should get index" do
    get price_formulas_url
    assert_response :success
  end

  test "should get new" do
    get new_price_formula_url
    assert_response :success
  end

  test "should create price_formula" do
    assert_difference('PriceFormula.count') do
      post price_formulas_url, params: { price_formula: { enable: @price_formula.enable, formula: @price_formula.formula, priceable: @price_formula.priceable } }
    end

    assert_redirected_to price_formula_url(PriceFormula.last)
  end

  test "should show price_formula" do
    get price_formula_url(@price_formula)
    assert_response :success
  end

  test "should get edit" do
    get edit_price_formula_url(@price_formula)
    assert_response :success
  end

  test "should update price_formula" do
    patch price_formula_url(@price_formula), params: { price_formula: { enable: @price_formula.enable, formula: @price_formula.formula, priceable: @price_formula.priceable } }
    assert_redirected_to price_formula_url(@price_formula)
  end

  test "should destroy price_formula" do
    assert_difference('PriceFormula.count', -1) do
      delete price_formula_url(@price_formula)
    end

    assert_redirected_to price_formulas_url
  end
end
