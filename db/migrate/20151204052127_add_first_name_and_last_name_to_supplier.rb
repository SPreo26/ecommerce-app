class AddFirstNameAndLastNameToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :first_name, :string
    add_column :suppliers, :last_name, :string
  end
end
