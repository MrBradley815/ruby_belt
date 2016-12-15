class Product < ActiveRecord::Base
  validates :name, :price, presence: true

  belongs_to :user, class_name: "User"
  belongs_to :buyer, class_name: "User"
end
