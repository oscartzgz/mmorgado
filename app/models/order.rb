class Order < ApplicationRecord
  belongs_to :client
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', required: true
  belongs_to :cashier, class_name: 'User', foreign_key: 'cashier_id', required: true
  has_many   :order_items
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: proc { |attr| attr['code'].blank? }

  def import
    order_items.sum(&:import)
  end
  
end
