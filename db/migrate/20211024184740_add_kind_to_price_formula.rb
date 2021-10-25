class AddKindToPriceFormula < ActiveRecord::Migration[6.1]
  def change
    add_column :price_formulas, :kind, :integer
  end
end
