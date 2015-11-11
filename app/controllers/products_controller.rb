class ProductsController < ApplicationController
  def index

    @last_visible_column_index = Product.column_names.length-2
    #this makes sure created_at and updated_at aren't shown
    #@message = params [:message]
    #@message2 = params [:message_2]

    #then access webpage via localhost/3000/parameters/?message=blahblah&message_2=blah
    #params is a hash
    
  end

end
