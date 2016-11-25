class Product < ApplicationRecord
  has_many :customizations
  has_and_belongs_to_many :tags
  belongs_to :user
  has_and_belongs_to_many :wishers,
                          class_name: 'User',
                          join_table: 'user_wishlist_product'
end
