class ChangeProductsTagsName < ActiveRecord::Migration[5.0]
  def change
    rename_table :product_tags, :products_tags
  end
end
