class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer 'product_id', :default => 0
      t.integer 'order_id', :default => 0
      t.integer 'quantity', :default => 1

      t.timestamps
    end
    add_index :cart_items, "product_id"
    add_index :cart_items, "order_id"
  end
end
