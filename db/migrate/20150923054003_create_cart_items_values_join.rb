class CreateCartItemsValuesJoin < ActiveRecord::Migration
  def change
    create_table :cart_items_values, :id => false do |t|
      t.integer "cart_items_values"
      t.integer "value_id"
    end
    add_index :cart_items_values, "cart_items_values"
    add_index :cart_items_values, "value_id"
  end
end
