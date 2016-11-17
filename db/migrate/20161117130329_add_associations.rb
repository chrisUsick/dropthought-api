class AddAssociations < ActiveRecord::Migration[5.0]
  def change
    add_reference :customizations, :product
    add_foreign_key :customizations, :product

    create_table :product_tags, id:false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :tag, index: true
    end
  end
end