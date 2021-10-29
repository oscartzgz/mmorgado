class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :model, :description, :credit_price,
             :cost_price, :provider_id, :product_brand_id,
             :product_category_id, :pp_price, :cash_price
end
