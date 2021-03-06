class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :model
      t.text :description
      t.decimal :list_price, precision: 8, scale: 2, null: false, default: 0
      t.integer :stock, null: false, default: 0
      t.integer :min_stock, null: false, defult: 1
      t.decimal :credit_price, precision: 10, scale: 2, default: 0
      t.decimal :cost_price, precision: 10, scale: 2, default: 0
      t.references :provider, null: false, foreign_key: true
      t.references :product_brand, null: false, foreign_key: true
      t.references :product_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
