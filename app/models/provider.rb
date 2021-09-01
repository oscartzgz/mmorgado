class Provider < ApplicationRecord
  has_many :products
  has_many :price_formulas
  has_many :product_brands, through: :products

  after_create do
    PriceFormulaUpdater.new(self).update
  end
end
