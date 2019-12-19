class ChangeJobColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :concract_type, :contract_type
  end
end
