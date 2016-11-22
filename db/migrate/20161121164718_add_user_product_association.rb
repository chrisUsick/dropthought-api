class AddUserProductAssociation < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :products, :users
  end
end
