class CartedProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: {greater_than: 0}
  validates :user_id, presence: true
end
