class ChangeTimeStampsToProduct < ActiveRecord::Migration[6.1]
  def change
    change_column_default :products, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :products, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
