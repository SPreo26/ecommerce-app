class ProductsController < ApplicationController
  
  def index

    @last_visible_column_index = Product.column_names.length-2
      #this makes sure created_at and updated_at aren't shown
      
      #@message = params [:message]
      #@message2 = params [:message_2]
      #then access webpage via localhost/3000/parameters/?message=blahblah&message_2=blah
      #params is a hash
      
  end

  def new
      
  end

  def create

    @product_info_to_create = []
    #p "the params are: #{params}"
    
    if params[:name] != ""
      @product_info_to_create << params[:name]
    else
      @product_info_to_create << nil
    end
    
    if params[:price]!= ""
      @product_info_to_create << params[:price].to_f
    else
      @product_info_to_create << nil
    end
    
    if params[:image]!= ""
      @product_info_to_create << params[:image]
    else
      @product_info_to_create << nil
    end

    if params[:description]!= ""
      @product_info_to_create << params[:description]
    else
      @product_info_to_create << nil
    end

    if @product_info_to_create.any? #this is to prevent empty form submissions from creating a contact
      Product.create

      @product_info_to_create.length.times do |index|

        Product.last.update\
                      ( {Product.column_names[index+1] => \
                        @product_info_to_create[index] }) #index+1 skips id and starts with first name
      end
    
    end

  end

  def show

    @last_visible_column_index = Product.column_names.length-2
    @id = params[:id].to_i
    
    @product = Product.find_by(id: @id)

    if @product      
      @product_id_exists = true    
    else
      @product_id_exists = false
    end

  end

  def destroy

    @id = params[:id].to_i
    @product = Product.find_by(id: @id)
    
    if @product
      @product.destroy
    else
      puts "Attempted to delete product: invalid ID"
    end

    redirect_to "/products"

  end

  def edit

    @id = params[:id].to_i
    @product = Product.find_by(id: @id)

    if @product       
      @product_id_exists = true
    else
      @product_id_exists = false
    end

  end

  def update
      
    @id = params[:id].to_i
    @product_info_to_edit = []    

    if params[:name] != ""
      @product_info_to_edit << params[:name]
    else
      @product_info_to_edit << nil
    end
    
    if params[:price] != ""
      @product_info_to_edit << params[:price].to_f
    else
      @product_info_to_edit << nil
    end
    
    if params[:image] != ""
      @product_info_to_edit << params[:image]
    else
      @product_info_to_edit << nil
    end

    if params[:description] != ""
      @product_info_to_edit << params[:description]
    else
      @product_info_to_edit << nil
    end

    if @product_info_to_edit.any? #this is to prevent empty form submissions from creating a contact
      product = Product.find_by(id: @id)
      @product_info_to_edit.length.times do |index|
        if @product_info_to_edit[index] #if the information in the given field is not empty (e.g. if something was actually typed for 'name' in the edit form)
        puts @product_info_to_edit[index]
        product.update\
                      ( {Product.column_names[index+1].to_sym => \
                        @product_info_to_edit[index] }) #index+1 skips id and starts with first name
        end
      end
    end

    redirect_to "/products/#{@id}"

  end

end