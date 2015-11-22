class ChangeInStockDefaultToTrueInProducts < ActiveRecord::Migration
  def change
    change_column :products, :in_stock, :boolean, default: true
  end
end
