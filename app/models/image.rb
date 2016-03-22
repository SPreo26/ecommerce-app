class Image < ActiveRecord::Base
  belongs_to :product, inverse_of: :images

  # validates :product_id, presence: true #probably need a ProductImages join table that has associations:
  #belongs_to :product, inverse_of: :product_images
  #belongs_to :image, inverse_of: :product_images 
  # to get a validation like this to work

  validates :url, presence: true
end
