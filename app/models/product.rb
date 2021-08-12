class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :product_brand
  belongs_to :product_category

  validates :code, presence: true
  validates :name, presence: true
  validates :stock, presence: true
  validates :min_stock, presence: true
  validates :list_price, presence: true
  
end
