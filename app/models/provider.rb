class Provider < ApplicationRecord
  has_many :products
  has_many :price_formulas, as: :priceable
  has_many :product_brands, through: :products
end
