# Represents a store's item listing
class Product < ApplicationRecord
  belongs_to :store
  has_many :variants, dependent: :destroy
  
  # Allow the product to accept multiple variants through nested attributes
  accepts_nested_attributes_for :variants
  
  validates :title, presence: true
end