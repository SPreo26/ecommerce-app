class OrdersController < ApplicationController

  def new
    @product_id = params[:product_id]
    @product_name = Product.find_by(id: @product_id).name
    @order_quantity = params[:order_quantity]
  end

  def create
    order_created = params[:order_created]

    @product_id = params[:product_id]
    @order_quantity = params[:order_quantity].to_i

    order=Order.create({quantity: @order_quantity, product_id: @product_id, user_id: current_user.id})

    redirect_to "/orders/#{order.id}/?order_created=#{order_created}"
  end

  def show
    @order_created = params[:order_created]
    if @order_created == "yes"
      @order_created = true
    else 
      @order_created = false
    end

    @id=params[:id]
    order=Order.find_by(id: @id)

    if order
      @product = order.product
      @product_name = @product.name
      @order_quantity = order.quantity
      @order_exists = true
    else
      @order_exists = false
    end
  end
end
