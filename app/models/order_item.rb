class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :orderable, polymorphic: true, optional: true

  def import
    quantity * price
  end
end
