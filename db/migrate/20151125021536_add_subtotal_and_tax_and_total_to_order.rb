class AddSubtotalAndTaxAndTotalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :subtotal, :decimal, scale: 2, precision: 9
    add_column :orders, :tax, :decimal, scale: 2, precision: 9
    add_column :orders, :total, :decimal, scale: 2, precision: 9
  end
end
