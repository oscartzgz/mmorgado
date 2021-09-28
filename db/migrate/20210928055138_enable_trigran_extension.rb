class EnableTrigranExtension < ActiveRecord::Migration[6.1]
  def up
    enable_extension('pg_trgm') unless extensions.include?('pg_trgm')
  end
  
  def down
    disable_extension('pg_trgm') if extensions.include?('pg_trgm')
  end
end
