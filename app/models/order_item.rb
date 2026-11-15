# Represents an individual line item within an order, linking an order to a specific product variant and quantity.
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant

  validates :quantity, :price, presence: true
end
