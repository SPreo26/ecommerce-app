class ChangePricePrecisionScaleLimitInProducts < ActiveRecord::Migration
  def change
    change_column :products, :price, :decimal, scale: 2, precision: 9, limit: 2000000
  end
end
