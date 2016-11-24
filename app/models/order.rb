class Order < ApplicationRecord
  has_many :customization_prices
  belongs_to :product
end
