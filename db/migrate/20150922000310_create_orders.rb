class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer 'store_id', :default => 0
      t.boolean 'status', :default => true
      t.timestamps
    end
    add_index :orders, :store_id
  end
end
