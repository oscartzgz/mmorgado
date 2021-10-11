class ChangeTimeStampsToProvider < ActiveRecord::Migration[6.1]
  def change
    change_column_default :providers, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :providers, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
