# Represents a customer checkout order belonging to a specific store and containing line items
class Order < ApplicationRecord
  belongs_to :store
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  validates :total_price, presence: true
end
