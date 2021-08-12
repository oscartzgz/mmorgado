class CreateProductBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :product_brands do |t|
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
