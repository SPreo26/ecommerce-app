class Product < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :user
  has_many :images
  has_many :orders

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

      return price*0.09

    end

  end

  def sale_message

    sale_message = ""

    if price && price < 2 #keeps message empty if price is nil
        sale_message = "Discounted Item!"
    else
        sale_message = "On Sale!"
    end

    return sale_message

  end
  
  #def is_item_attr_below_img?(attribute)
  #  attr_index = Product.column_names.index(attribute)
  #  image_index = Product.column_names.index("image")
  #
  #  if attr_index > image_index
  #      return "item_attr_below_img"
  #  else
  #      return "item_attr_not_below_img"
  #  end
  # 
  #end

end
