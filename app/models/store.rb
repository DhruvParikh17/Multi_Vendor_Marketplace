# links a user to their products ad orders
class Store < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy 
  
  validates :name, :slug, presence: true, uniqueness: true
end