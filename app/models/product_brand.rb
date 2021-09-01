class ProductBrand < ApplicationRecord
  validates :name, presence: true
  has_many :products
  has_many :price_formulas, as: :priceable

  after_create do
    PriceFormulaUpdater.new().update
  end
end
