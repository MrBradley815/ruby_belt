class User < ActiveRecord::Base
  has_secure_password
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
  validates :first, :last, presence: true

  has_many :products, class_name: "Product", foreign_key: :user_id
  has_many :bought_products, class_name: "Product", foreign_key: :buyer_id
end
