class ChangeTimeStampsToClient < ActiveRecord::Migration[6.1]
  def change
    change_column_default :clients, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :clients, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
