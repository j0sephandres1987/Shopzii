class AddClientNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, 'client_name', :string
  end
end
