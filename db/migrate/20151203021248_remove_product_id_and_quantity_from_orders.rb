class RemoveProductIdAndQuantityFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :quantity, :integer
    remove_column :orders, :product_id, :integer
  end
end
