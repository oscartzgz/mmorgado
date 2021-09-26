class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :product_brand
  belongs_to :product_category
  has_many :price_formulas, as: :priceable

  validates :code, presence: true
  validates :name, presence: true
  validates :stock, presence: true
  validates :min_stock, presence: true
  validates :list_price, presence: true
  
  before_save :assign_cost_price

  after_create do
    PriceFormulaUpdater.new(self).update
  end

  def self.out_of_minimum_stock
    self.all.select(&:is_minimum_stock?)
  end

  def is_minimum_stock?
    self.stock <= self.min_stock
  end

  def all_price_formulas
    PriceFormula.where(provider: provider, priceable: [product_brand, self] ).active
  end

  def brand_price_formulas
    all_price_formulas.where(priceable: product_brand )
  end

  def product_price_formulas
    all_price_formulas.where(priceable: self )
  end

  private

  def assign_cost_price
    self.cost_price = calc_cost_price
  end

  def calc_cost_price
    applyable_price_formulas =
      all_price_formulas.reject{ |pf|
        (pf.priceable_type == 'ProductBrand' && all_price_formulas.where(
            priceable_type: 'Product',
            name: pf.name).count >= 1)}

    list_price + applyable_price_formulas.sum(&:final_value)
  end
end
