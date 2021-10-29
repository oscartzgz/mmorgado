class CreateProviderContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :provider_contacts do |t|
      t.string :full_name, null: false
      t.string :role
      t.string :email
      t.string :phone_number
      t.string :mobile_number
      t.boolean :primary_contact, default: false
      t.references :provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
