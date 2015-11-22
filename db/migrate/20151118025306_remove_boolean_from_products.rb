class RemoveBooleanFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :boolean, :string
  end
end
