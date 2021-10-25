class PriceFormula < ApplicationRecord
  FORMULA_KINDS = {
    cost_price: 0,
    credit_price: 1,
    pp_cash_price:2,
    cash_price: 3,
    expo_pp_cash_price: 4,
    expo_card_price: 5,
    christmas_pp_cash_price: 6,
    christmas_cash_price: 7
  }
  
  belongs_to :provider
  belongs_to :priceable, polymorphic: true

  validates :formula, format: { 
                        with: /\A[+-]?\d+[.]?\d{1,2}?\z/,
                        message: 'La formula no tiene la estructura correcta' }
  validates :name, uniqueness: { scope: [:priceable_type, :priceable_id, :provider_id] }

  enum kind: FORMULA_KINDS

  scope :active,   -> { where(enable: true) }
  scope :inactive, -> { where(enable: false) }

  def final_value
    values = formula.split(/[+-]/).map(&:to_i)
    signs  = formula.split(/\d+/).reject(&:empty?)
    
    result = 0

    values.each_with_index do |value, index|
      unless index == 0
        value = signs[index -1] == '+' ? value : (value * -1)
      end
      result += value
    end

    result
  end
end
