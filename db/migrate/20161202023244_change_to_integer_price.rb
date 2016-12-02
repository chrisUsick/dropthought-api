class ChangeToIntegerPrice < ActiveRecord::Migration[5.0]
  def change
    change_column :customization_prices, :price, :integer
    change_column :customizations, :price, :integer
    change_column :orders, :price, :integer
    change_column :products, :price, :integer
  end
end
