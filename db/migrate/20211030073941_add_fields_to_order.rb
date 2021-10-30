class AddFieldsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivered, :boolean, default: false
    add_column :orders, :payed, :boolean, default: false
    add_column :orders, :cash_on_delivery, :boolean, default: false
  end
end
