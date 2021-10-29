class Order < ApplicationRecord
  belongs_to :client
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', required: true
  belongs_to :cashier, class_name: 'User', foreign_key: 'cashier_id', required: true
end
