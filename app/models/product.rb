class Product < ActiveRecord::Base
  belongs_to :supplier, inverse_of: :products
  belongs_to :user
  has_many :images, inverse_of: :product
  has_many :categorized_products
  has_many :categories, through: :categorized_products
  accepts_nested_attributes_for :images, :supplier

  validates :price, numericality: { greater_than: 0 }
  validates :description, length: { minimum: 5, maximum: 2000}
  validates :name, length: { minimum: 2, maximum: 255}  

  def self.number_of_columns
    number_of_columns = Product.column_names.length
  end
  
  def self.get_discounted
    Product.where("price < ?", 2)
  end

  def self.boolean_to_yes_no (boolean)
    boolean ? 'Yes' : 'No'
  end

  def friendly_update_time
    updated_at.strftime "%A, %d %b %Y %l:%M %p"
  end

  def get_image_urls
    images.pluck(:url)
  end

  def item_tax
    if price
      price*0.09
    end
  end

  def sale_message
    if price && price < 2 #keeps message empty if price is nil
        "Discounted Item!"
    else
        "On Sale!"
    end
  end
  
  # def is_item_attr_below_img?(attribute)
  #  attr_index = Product.column_names.index(attribute)
  #  image_index = Product.column_names.index("image")
  
  #  if attr_index > image_index
  #      return "item_attr_below_img"
  #  else
  #      return "item_attr_not_below_img"
  #  end
  
  # end

end
