class AddInStockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :in_stock, :string
    add_column :products, :boolean, :string
  end
end
