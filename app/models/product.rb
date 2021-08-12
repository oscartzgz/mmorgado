class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :product_brand
  belongs_to :product_category
end
