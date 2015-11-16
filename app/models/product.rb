class Product < ActiveRecord::Base

  def friendly_update_time

    updated_at.strftime "%A, %d %b %Y %l:%M %p"

  end

end
