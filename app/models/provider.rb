class Provider < ApplicationRecord
  has_many :products
  has_many :price_formulas
  has_many :product_brands, through: :products

  validates_presence_of :full_name, :address, :contact_full_name,
                        :phone_number, :contact_mobile_number

  after_create do
    PriceFormulaUpdater.new(self).update
  end
end
