class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.string :code
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2, default: 0
      t.integer :kind
      t.integer :payment_type
      t.references :order, null: false, foreign_key: true
      t.references :orderable, polymorphic: true

      t.timestamps
    end
  end
end
