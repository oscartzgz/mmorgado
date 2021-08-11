class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :first_surname
      t.string :second_surname
      t.string :address
      t.string :location
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :email
      t.string :mobile_number
      t.string :phone_number
      t.string :endorsement_full_name
      t.string :endorsement_mobile_phone
      t.string :endorsement_phone_number
      t.string :endorsement_address
      t.string :endorsement_location
      t.string :endorsement_country
      t.string :endorsement_postal_code
      t.string :endorsement_relationship

      t.timestamps
    end
  end
end
