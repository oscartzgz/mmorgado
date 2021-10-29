class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :full_name
      t.string :phone_number
      t.string :address
      t.string :state
      t.string :city
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end
