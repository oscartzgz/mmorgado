class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :product_brand
  belongs_to :product_category

  validates :code, presence: true
  validates :name, presence: true
  validates :stock, presence: true
  validates :min_stock, presence: true
  validates :list_price, presence: true
  
  def self.out_of_minimum_stock
    self.all.select(&:is_minimum_stock?)
  end

  def is_minimum_stock?
    self.stock <= self.min_stock
  end

end
