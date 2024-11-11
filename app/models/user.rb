class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password
  attr_accessor :password_digest

  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  validates_format_of :email,  with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address"
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
