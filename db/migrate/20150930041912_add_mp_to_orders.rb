class AddMpToOrders < ActiveRecord::Migration
  def change
    add_column :orders, 'payment_id', :string
  end
end
