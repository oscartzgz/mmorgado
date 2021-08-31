class CreatePriceFormulas < ActiveRecord::Migration[6.0]
  def change
    create_table :price_formulas do |t|
      t.boolean :enable, default: true
      t.string :formula
      t.references :priceable, polymorphic: true
      t.references :provider

      t.timestamps
    end
  end
end
