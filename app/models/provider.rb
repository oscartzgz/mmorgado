class Provider < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :price_formulas
  has_many :product_brands, through: :products

  validates :code, uniqueness: true
  validates :full_name, uniqueness: true

  validates :code, :address,
            :contact_full_name, :phone_number,
            :contact_mobile_number,
            presence: true

  validates :full_name, presence: true

  after_create do
    PriceFormulaUpdater.new(self).update
  end
end
