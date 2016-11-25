class AddUserProductAssociation < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :users, foreign_key: true
  end
end
