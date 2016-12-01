class OrdersAddRefToFulfiller < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :fulfiller_id, :integer
    add_foreign_key :orders, :users, column: :fulfiller_id
  end
end
