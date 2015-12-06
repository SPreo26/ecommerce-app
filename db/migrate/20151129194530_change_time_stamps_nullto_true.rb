class ChangeTimeStampsNulltoTrue < ActiveRecord::Migration
  def change
    change_column :categorized_products, :created_at, :datetime, null: true
    change_column :categorized_products, :updated_at, :datetime, null: true
  end
end
