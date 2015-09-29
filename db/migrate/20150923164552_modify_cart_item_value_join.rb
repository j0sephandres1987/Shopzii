class ModifyCartItemValueJoin < ActiveRecord::Migration
  def change
    remove_column :cart_items_values, "cart_items_values"
    add_column :cart_items_values, "cart_item_id", :integer, :default => 0
    add_index :cart_items_values, "cart_item_id"
  end
end
