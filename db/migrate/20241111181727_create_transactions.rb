class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.references :wallet_from, null: false, foreign_key: { to_table: :wallets }
      t.references :wallet_to, null: false, foreign_key: { to_table: :wallets }
      t.integer :type
      t.integer :status
      t.integer :pin

      t.timestamps
    end
  end
end
