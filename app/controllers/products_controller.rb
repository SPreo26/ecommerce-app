class ProductsController < ApplicationController
  def index
    @message = params [:message]
    @message2 = params [:message_2]

    #then access webpage via localhost/3000/parameters/?message=blahblah&message_2=blah
    #params is a hash
    
  end

end
