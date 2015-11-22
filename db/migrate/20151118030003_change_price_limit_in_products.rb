class ChangePriceLimitInProducts < ActiveRecord::Migration
  def change
    change_column :products, :price, :decimal, limit: 2000000
  end
end