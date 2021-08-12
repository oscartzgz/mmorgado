json.extract! product_category, :id, :name, :active, :created_at, :updated_at
json.url product_category_url(product_category, format: :json)
