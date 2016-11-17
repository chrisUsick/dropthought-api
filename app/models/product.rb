class Product < ApplicationRecord
  has_many :customizations
  has_and_belongs_to_many :tags
end
