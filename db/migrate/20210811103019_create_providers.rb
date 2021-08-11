class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :full_name
      t.string :phone_number
      t.string :address
      t.string :city
      t.string :country
      t.string :postal_code
      t.string :contact_full_name
      t.string :contact_email
      t.string :contact_phone_number
      t.string :contact_mobile_number

      t.timestamps
    end
  end
end
