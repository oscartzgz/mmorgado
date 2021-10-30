class OrderItem < ApplicationRecord
  enum kind: { product: 0, freight: 1, discount: 2 }
  
  belongs_to :order
  belongs_to :orderable, polymorphic: true, optional: true

  def import
    quantity * price
  end
end
