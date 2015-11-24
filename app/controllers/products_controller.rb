class ProductsController < ApplicationController
  
  def index
    @number_of_columns = Product.column_names.length
    
    @products_subset = Product.all
    @product_index_is_discounted = false
    product_created_string = params[:created]

    if product_created_string == "no"
      @product_create_failed = true
    else
      @product_create_failed = false
    end
  end

  def products_ordered_price_asc
    @number_of_columns = Product.column_names.length
    
    @products_subset = Product.all.order(price: :asc)

    render :index
  end

  def products_ordered_price_desc
    @number_of_columns = Product.column_names.length
    @products_subset = Product.all.order(price: :desc)

    render :index
  end

  def discounted
    @number_of_columns = Product.column_names.length
    
    @products_subset = Product.get_discounted
    @product_index_is_discounted = true
    
    render :index
  end

  def random
    @number_of_columns = Product.column_names.length
    
    @product = Product.all.sample
    @id = @product.id
    @product_id_exists=true
    @product_show_is_random = true

    @supplier_name = @product.supplier.name

    render :show
  end

  def new
      
  end

  def create
    @id = params[:id].to_i
    @product_info_to_create = {}

    if params[:name] != ""
      @product_info_to_create["name"] = params[:name]
    end
    
    if params[:price] != ""
      @product_info_to_create["price"] = params[:price].to_f
    end

    if params[:description] != ""
      @product_info_to_create["description"] = params[:description]
    end

    if @product_info_to_create.any? || params[:image] != ""#this is to prevent empty form submissions from creating a contact
      product = Product.create
      @id=product.id

      @product_info_to_create.each do |column_name, column_value|
        product.update({column_name.to_sym => column_value})
      end

      if params[:image] != ""
        Image.create({url: params[:image], product_id: @id})
      end

      product.update(user_id: current_user.id)
      supplier_name = params[:supplier_name]
      supplier = Supplier.find_by(name: supplier_name)

      if supplier
        existing_supplier_id = supplier.id
        product.update(supplier_id: existing_supplier_id)
      else
        supplier=Supplier.create(name: supplier_name)
        new_supplier_id = supplier.id
        product.update(supplier_id: new_supplier_id)

      end

      redirect_to "/products/#{@id}/?created=yes"

    else

      redirect_to "/products/?created=no"

    end
  end

  def show
    @number_of_columns = Product.column_names.length
    
    @id = params[:id].to_i
    product_created_string = params[:created]
    @product = Product.find_by(id: @id)

    if product_created_string == "yes"
      @product_created = true
    else
      @product_created = false
    end

    if @product      
      @product_id_exists = true
      @supplier_name = @product.supplier.name   
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
    @product_info_to_edit = {}

    if params[:name] != ""
      @product_info_to_edit["name"] = params[:name]
    end
    
    if params[:price] != ""
      @product_info_to_edit["price"] = params[:price].to_f
    end

    if params[:description] != ""
      @product_info_to_edit["description"] = params[:description]
    end

    if @product_info_to_edit.any? || params[:image] != "" #this is to prevent empty form submissions from creating a contact
    
      product = Product.find_by(id: @id) 
      
      @product_info_to_edit.each do |column_name, column_value|
        product.update(column_name.to_sym => column_value) 
      end
      
    end

    redirect_to "/products/#{@id}"
  end

end
