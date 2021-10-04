class AddCodeAndEmailToProvider < ActiveRecord::Migration[6.1]
  def change
    add_column :providers, :code, :string, unique: true, null: false
    add_column :providers, :kind, :string
    add_column :providers, :email, :string
    add_index :providers, :code
  end
end
