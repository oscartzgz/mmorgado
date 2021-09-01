class AddNameToPriceFormula < ActiveRecord::Migration[6.0]
  def change
    add_column :price_formulas, :name, :string, null: false, default: ''
  end
end
