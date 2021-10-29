class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :code
      t.string :payment_type
      t.references :client, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :cashier, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
