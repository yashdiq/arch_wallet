class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  has_one :wallet

  attr_accessor :transactions

  has_secure_password

  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  validates_format_of :email,  with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address"
  validates :password, presence: true

  accepts_nested_attributes_for :wallet
end
