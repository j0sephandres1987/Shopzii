class OrderStatusFalse < ActiveRecord::Migration
  def change
    remove_column :orders, "status"
    add_column :orders, 'status', :boolean, :default => false
  end
end
