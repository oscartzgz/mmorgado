class AddPpPriceAndCashPriceToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :pp_price, :decimal, precision: 10, scale: 2, default: 0
    add_column :products, :cash_price, :decimal, precision: 10, scale: 2, default: 0
  end
end
