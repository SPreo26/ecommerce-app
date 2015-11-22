class ChangePriceToDecimalWithPreciscionAndBoundsOfProduct < ActiveRecord::Migration
  def change
    change_column :products, :price, :decimal, precision: 2, limit: 2000000
  end
end
