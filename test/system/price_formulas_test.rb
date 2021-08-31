require "application_system_test_case"

class PriceFormulasTest < ApplicationSystemTestCase
  setup do
    @price_formula = price_formulas(:one)
  end

  test "visiting the index" do
    visit price_formulas_url
    assert_selector "h1", text: "Price Formulas"
  end

  test "creating a Price formula" do
    visit price_formulas_url
    click_on "New Price Formula"

    check "Enable" if @price_formula.enable
    fill_in "Formula", with: @price_formula.formula
    fill_in "Priceable", with: @price_formula.priceable
    click_on "Create Price formula"

    assert_text "Price formula was successfully created"
    click_on "Back"
  end

  test "updating a Price formula" do
    visit price_formulas_url
    click_on "Edit", match: :first

    check "Enable" if @price_formula.enable
    fill_in "Formula", with: @price_formula.formula
    fill_in "Priceable", with: @price_formula.priceable
    click_on "Update Price formula"

    assert_text "Price formula was successfully updated"
    click_on "Back"
  end

  test "destroying a Price formula" do
    visit price_formulas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Price formula was successfully destroyed"
  end
end
