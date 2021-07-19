class AddUsernameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, unique: true
    add_column :users, :active, :boolean, null: false, default: false
  end
end
