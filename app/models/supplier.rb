class Supplier < ActiveRecord::Base
  has_many :products, inverse_of: :supplier
  validates :company_name, presence: true
end
