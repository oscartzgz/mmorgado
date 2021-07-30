class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :first_surname
      t.string :second_surname
      t.string :postal_code
      t.string :state
      t.string :location
      t.string :mobile_number
      t.string :suburb
      t.string :street
      t.string :ext_num
      t.string :int_num
      t.string :phone_number
      t.string :photo

      t.timestamps
    end
  end
end
