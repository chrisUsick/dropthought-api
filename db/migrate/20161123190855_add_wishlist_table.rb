class AddWishlistTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_wishlist_product, id:false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
    end
  end
end
