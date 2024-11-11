class Transaction < ApplicationRecord
  belongs_to :wallet_from, class_name: 'Wallet', foreign_key: 'wallet_from_id', required: true
  belongs_to :wallet_to, class_name: 'Wallet', foreign_key: 'wallet_to_id', required: true
  enum type: {
    credit: 0,
    debit: 1, 
    deposit: 2,
    withdraw: 3
  }
  enum status: {
    pending: 0,
    settlement: 1,
    cancel: 2,
    failure: 3
  }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :wallet_from, presence: true
  validates :wallet_to, presence: true
  validates :pin, presence: true
end
