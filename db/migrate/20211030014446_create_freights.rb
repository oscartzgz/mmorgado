class CreateFreights < ActiveRecord::Migration[6.1]
  def change
    create_table :freights do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :kind
      t.decimal :import, precision: 10, scale: 2, default: 0
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
