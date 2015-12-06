class Supplier < ActiveRecord::Base
  has_many :products

  validates :company_name, presence: true
end
