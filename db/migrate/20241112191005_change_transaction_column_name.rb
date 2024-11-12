class ChangeTransactionColumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :type, :transaction_type
    rename_column :transactions, :status, :transaction_status
  end
end
