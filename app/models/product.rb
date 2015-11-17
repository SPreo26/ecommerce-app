class Product < ActiveRecord::Base

  def self.get_discounted

    Product.where("price < ?",2)

  end

  def friendly_update_time

    updated_at.strftime "%A, %d %b %Y %l:%M %p"

  end

  def sale_message

    if price < 2
        sale_message = "Discounted Item!"
    else
        sale_message = "On Sale!"
    end

    return sale_message

  end

  def item_tax

    price*0.09

  end

  def is_item_attr_below_img?(attribute)
    attr_index = Product.column_names.index(attribute)
    image_index = Product.column_names.index("image")

    if attr_index > image_index
        return "item_attr_below_img"
    else
        return "item_attr_not_below_img"
    end

  end

end
