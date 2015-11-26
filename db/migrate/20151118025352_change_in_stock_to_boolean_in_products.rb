class ChangeInStockToBooleanInProducts < ActiveRecord::Migration
  def change
    change_column :products, :in_stock, 'boolean USING(trim(price)::boolean)'
  end
end
