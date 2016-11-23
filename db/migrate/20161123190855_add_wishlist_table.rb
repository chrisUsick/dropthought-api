class AddWishlistTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_wishlist_product, id:false do |t|
      t.belongs_to :users, index: true
      t.belongs_to :products, index: true
    end
  end
end
