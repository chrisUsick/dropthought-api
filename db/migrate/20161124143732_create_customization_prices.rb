class CreateCustomizationPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :customization_prices do |t|
      t.belongs_to :order, index: true
      t.belongs_to :customization, index: true 
      t.decimal :price
      t.timestamps
    end
  end
end
