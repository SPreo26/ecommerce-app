class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    carted_products = current_user.carted_products.where(status: "carted")
    if carted_products.any? #if cart is not empty
      @subtotal=calc_subtotal(carted_products)
      @tax=calc_tax(carted_products)
      @total=@subtotal+@tax
      @order=Order.new({user_id: current_user.id, subtotal: @subtotal, tax: @tax, total: @total})
      if @order.valid?
        @order.save
        carted_products.update_all(status:"ordered", order_id:@order.id)
        session[:cart_count] = 0
        flash[:success] = "Order successful!"
        redirect_to "/orders/#{@order.id}"
      else
        flash[:danger] = "Order could not be completed!"
        redirect_to "/carted_products"
      end
    else
      flash[:danger] = "Could not proceed with order. Your cart is empty!"
      redirect_to "/carted_products"
    end
  end

  def show   
    @id=params[:id]
    @order=Order.find_by(id: @id)
    if !@order
      flash[:danger] = "Order ID #{@id} doesn't exist!"
    end

  end
end
