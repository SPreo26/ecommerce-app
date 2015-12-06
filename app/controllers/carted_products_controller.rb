class CartedProductsController < ApplicationController

  def index
    if current_user
    @carted_products=current_user.carted_products.where(status: "carted")
    @subtotal = calc_subtotal(@carted_products)
    @tax = calc_tax(@carted_products)
    @total = @subtotal + @tax
    else
    flash[:danger] = "You must be signed in to view the cart!"
    end
  end
  
  def create
    product_id = params[:product_id]
    carted_quantity = params[:carted_quantity].to_i

    if current_user
      user_id = current_user.id
    else
      user_id = nil #a user shouldn't have to log in until they actually make an order
    end

    carted_product = CartedProduct.new({user_id:user_id, product_id:product_id, quantity:carted_quantity, status:"carted"})
    if carted_product.valid?
      
      existing_carted_product = CartedProduct.find_by(user_id:user_id, product_id:product_id, status:"carted")  
      if existing_carted_product
        existing_carted_product.update(quantity: (existing_carted_product.quantity+carted_quantity) )
        #if this product is already carted by this user, simply add to the quantity
      else
        carted_product.save #otherwise save as new product
      end

      session[:cart_count] += carted_product.quantity
      flash[:success] = "Added #{carted_quantity} to Cart!"
      redirect_to "/products/#{product_id}"
    else
      @carted_errors = carted_product.errors.full_messages
      redirect_to "/products/#{product_id}", request.parameters.merge(carted_errors: @carted_errors)
    end
  
  end

  def destroy
    carted_product=CartedProduct.find_by(id:params[:id])
    if carted_product
      carted_product.update(status:"removed")
      session[:cart_count] -= carted_product.quantity
    else
      flash[:danger]="Can't remove from cart: product id #{params[:id]} doesn't exist!"
    end
    redirect_to "/carted_products/"
  end

end
