class ProductsController < ApplicationController
  #before_action :authenticate_admin, except: [:index, ...]
  #before_action :authenticate_admin, only: [:index, ...]
  before_action :authenticate_admin!, except: [:know_your_role, :index, :products_ordered_price_asc, :products_ordered_price_desc, :show, :random]

  def know_your_role
  end

  def index
    @number_of_columns = Product.column_names.length
    
    @product_index_is_discounted = false
    @product_index_is_categorized = false

    if params[:category]
      @category = Category.find_by(name: params[:category])
      @products_subset = @category.products
      @product_index_is_categorized = true
    elsif params[:discounted]=="yes"
      @products_subset = Product.get_discounted
      @product_index_is_discounted = true
    else
      @products_subset = Product.all
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

  def show    
    @id = params[:id].to_i
    @product = Product.find_by(id: @id)

    unless @product      
      flash.now[:danger] = "Product Id #{@id} doesn't exist!"
    end
  end

  def random
    @number_of_columns = Product.column_names.length
    
    @product = Product.all.sample
    @id = @product.id
    @product_id_exists=true
    @product_show_is_random = true

    render :show
  end

  def new
       @product = Product.new
       @product.images.build 
  end

  def search
    search_term = params[:search]
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{search_term}", "%#{search_term}")
  end

  def create
    @product_info_to_create = {}
    
    @product_info_to_create["name"] = params[:name]
    @product_info_to_create["price"] = params[:price].to_f
    @product_info_to_create["description"] = params[:description]

    @product = Product.new

    @product_info_to_create.each do |column_name, column_value|
      @product.send("#{column_name}=",column_value)#eg. convert column_name such as "name" and column_value such as "car"
      #to @product.name="car"
    end

    @product.user_id = current_user.id

    if params[:image] != ""
      image=Image.new({url: params[:image]})
    else
      image=Image.new
    end

    @create_error_messages = []

    if image.invalid?
      @create_error_messages += image.errors.full_messages
    end

    if @product.valid?
      
      image.product_id=@product.id

      if image.valid?
        image.save
      end

      supplier.company_name = params[:supplier.company_name]
      supplier = Supplier.find_by(name: supplier.company_name)
      if supplier
        existing_supplier_id = supplier.id
        @product.update(supplier_id: existing_supplier_id)
      else
        supplier=Supplier.new(name: supplier.company_name)
        supplier.save
        new_supplier_id = supplier.id
        @product.update(supplier_id: new_supplier_id)
      end

      @number_of_columns = Product.column_names.length

      @product.save
      flash.now[:success] = "New product created!"  
      render "/products/show"

    else #if product.invalid?
      @product_create_failed = true
      @create_error_messages += @product.errors.full_messages
      p @create_error_messages
      render "/products/new"
    end

  end

  def destroy
    @id = params[:id].to_i
    @product = Product.find_by(id: @id)
    name=@product.name
    
    if @product
      @product.destroy
    else
      puts "Attempted to delete product: invalid ID"
    end
    flash.now[:success] = "Item #{name} deleted!"  
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

  def product_params
    params.require(:product).permit(:id, :name, :description, :supplier_id, images_attributes: [:url])
  end

end
