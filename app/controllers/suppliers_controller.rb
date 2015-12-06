class SuppliersController < ApplicationController

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.valid?
      @supplier.save
      redirect_to "/suppliers/#{@supplier.id}"
    else
      flash.now[:danger]="Supplier info not valid!"
      redirect_to "/suppliers/new"
    end
  end

  def show

    @supplier = Supplier.find_by(id: params[:id])
    unless @supplier
      flash.now[:danger]="Supplier id #{params[:id]} dozen exiss!"
      redirect_to "/suppliers/index"
    end

  end

  def supplier_params
    params.require(:supplier).permit(:company_name, :first_name, :last_name, :email, :phone)
  end

  def update
    @supplier = Supplier.find_by(id: params[:id])
    if @supplier
      @supplier.update(supplier_params)
      redirect to "/suppliers/#"
    else
      flash.now[:danger]="Supplier id #{params[:id]} dozen exiss!"
      redirect_to "/suppliers/index"
    end
  end
end
