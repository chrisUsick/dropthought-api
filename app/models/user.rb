class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  include DeviseTokenAuth::Concerns::User

  def self.find_for_verified_token_response(auth)
    user = User.where(provider: 'google_oauth2', uid: auth[:sub]).first

    unless user
      user = User.new(name: auth[:name],
                      email: auth[:email],
                      provider: 'google_oauth2',
                      uid: auth[:sub])
      user.save validate: false
    end

    user
  end

  has_many :products
  has_and_belongs_to_many :wishlist_products,
    class_name: 'Product',
    join_table: 'user_wishlist_product'
  has_many :orders
end
