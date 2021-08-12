json.extract! product, :id, :code, :name, :model, :description, :list_price, :stock, :min_stock, :credit_price, :cost_price, :provider_id, :product_brand_id, :product_category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
