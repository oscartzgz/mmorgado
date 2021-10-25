class Provider < ApplicationRecord
  include PgSearch::Model

  has_many :products, dependent: :destroy
  has_many :price_formulas
  # has_many :product_brands, through: :products

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

  pg_search_scope :search_scope_full,
                  against: [:full_name],
                  using: {
                    tsearch: {
                      any_word: true
                    },
                    trigram: {
                      threshold: 0.1
                    }
                  }
  
  scope :distributor, -> { where(kind: 'Distribuidor') }
  scope :maker, -> { where(kind: 'Fabricante') }

  def self.search(params)
    providers = self.all.order(full_name: :asc)
    providers = providers.search_scope_full(params[:full_data]) if params[:full_data]
    providers
  end

  def full_name_and_kind
    "#{full_name} (#{kind})"
  end

  def is_maker?
    kind == 'Fabricante'
  end

  def is_distributor?
    kind == 'Distribuidor'
  end

  def product_brands
    if is_maker?
      ProductBrand.where(name: full_name)
    elsif is_distributor?
      ProductBrand.all
    end
  end
end
