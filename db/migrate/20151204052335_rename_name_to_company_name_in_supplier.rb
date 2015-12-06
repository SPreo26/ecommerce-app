class RenameNameToCompanyNameInSupplier < ActiveRecord::Migration
  def change
    rename_column :suppliers, :name, :company_name
  end
end
