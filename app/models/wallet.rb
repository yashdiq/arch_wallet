class Wallet < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  has_many :transactions, dependent: :destroy

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
