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
    if @product.images.empty?
      @product.images.build
    end
  end

  def search
    @search_term = params[:search].downcase
    @products_subset = Product.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{@search_term}%", "%#{@search_term}%")
    @product_index_is_search_results = true
    render :index
  end

  def create

    @product = Product.new(product_params)
    @product.user_id = current_user.id
    # images_params = product_params[:images_attributes]
    # p "ALL IMAGES"
    # p @product.images
    # p "AFTER"
    # @product.images.build
    # p @product.images
    # @product.images.each_with_index do |image, index|
    #   p "CLASS"
    #   p images_params[index.to_s].class
    #   image.update(product_id)
    #   p "image #{index}"
    #   p @product.images[index]
    # end
    

    # images=[]
    # p images_params
    # images_params.each_value do |image_params|
    #   p image_params
    #   images<<Image.new({product_id: @product.id, url: image_params["url"]})
    # end

    # @create_error_messages = []
    
    # if image.invalid?
    #   @create_error_messages += image.errors.full_messages
    # end

    if @product.valid?
      
      # images.each do |image|
      #   if image.valid?
      #     image.save
      #   end
      # end

      # supplier.company_name = params[:supplier.company_name]
      # supplier = Supplier.find_by(name: supplier.company_name)
      # if supplier
      #   existing_supplier_id = supplier.id
      #   @product.update(supplier_id: existing_supplier_id)
      # else
      #   supplier=Supplier.new(name: supplier.company_name)
      #   supplier.save
      #   new_supplier_id = supplier.id
      #   @product.update(supplier_id: new_supplier_id)
      # end

      # @number_of_columns = Product.column_names.length

      @product.save
      flash.now[:success] = "New product created!"  
      render "/products/show"

    else #if product.invalid?
      @product_create_failed = true
      @create_error_messages = @product.errors.full_messages
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
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to "/products/#{@id}"
  end

  def product_params
    product_params = params.require(:product).permit(:id, :name, :price, :description, :supplier_id, images_attributes: [:id, :url])
    product_params[:id]=params[:id]
    return product_params
  end

  def image_params
    images_params = params.require(:product).permit(images_attributes: [:id, :url])
  end  

end
