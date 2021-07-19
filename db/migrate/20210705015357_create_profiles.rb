class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :first_surname
      t.string :second_surname
      t.string :postal_code
      t.string :state
      t.string :location
      t.string :suburb
      t.string :street
      t.string :ext_number
      t.string :int_number
      t.string :mobile_number
      t.string :phone_number

      t.timestamps
    end
  end
end
