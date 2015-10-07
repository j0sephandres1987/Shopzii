class ModifyOrders < ActiveRecord::Migration
  def change
    add_column :orders, 'total_value', :integer, :default => 0
    add_column :orders, 'client_email', :string
  end
end
