class Order < ApplicationRecord
  belongs_to :client
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', required: true
  belongs_to :cashier, class_name: 'User', foreign_key: 'cashier_id', required: true
  has_many   :order_items
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: proc { |attr| attr['code'].blank? }

  after_create :set_orderable_freights


  def import
    order_items.sum(&:import)
  end
  
  private

  def set_orderable_freights
    order_items.where(kind: :freight).each do |order_item_freight|
      unless order_item_freight.orderable
        new_freight = Freight.create({
          client_id: client_id,
          kind: 0,
          import: order_item_freight.price,
          order_id: id,
          user_id: cashier_id,
        })
        order_item_freight.update(orderable: new_freight)
      end
    end
  end

end
