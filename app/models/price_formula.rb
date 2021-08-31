class PriceFormula < ApplicationRecord
  belongs_to :provider
  belongs_to :priceable, polymorphic: true

  validates :formula, format: { 
                        with: /\A\d+[+-]\d+[+-]\d+\z/,
                        message: 'La formula no tiene la estructura correcta' }


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
