class AddPositiveBalanceAndCodeToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :positive_balance, :decimal, precision: 10, scale: 2, default: 0
    add_column :clients, :code, :string, unique: true, null: false

    add_index :clients, :code
  end
end
