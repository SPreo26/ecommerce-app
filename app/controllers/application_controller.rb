class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :calc_cart_count

  private 

  def authenticate_admin!
    if !current_user || !current_user.role.admin?
      flash[:danger] = "Error: you must be an administrator to view this page."
      redirect_to "/know_your_role"
    end
  end

  def calc_cart_count
    if current_user
      if session[:cart_count]#if the cart_count is already stored in session cookie
        @cart_count = session[:cart_count]
      else#should only run once per session to limit number of database operations
        session[:cart_count] = current_user.carted_products.where(status:"carted").count
      end
    end
  end

  def calc_subtotal(carted_products)
    subtotal = 0
    carted_products.each do |carted_product|
      subtotal += carted_product.product.price * carted_product.quantity
    end
    return subtotal
  end

  def calc_tax(carted_products)
    tax = 0
    carted_products.each do |carted_product|
      tax += carted_product.product.item_tax
    end
    return tax
  end

end
