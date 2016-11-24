class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :price
      t.string :status
      t.belongs_to :product, index: true
      t.timestamps
    end
  end
end
