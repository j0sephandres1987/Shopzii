class CreateShipments < ActiveRecord::Migration
  def up
    create_table :shipment_methods do |t|
      t.string 'name', :limit => 50, :null => false
      t.string 'delivery_time'
      t.integer 'price', :default => 0
      t.integer 'store_id', :default => 0
      t.integer 'product_id', :default => 0
      t.boolean 'free', :default => false
      t.boolean 'status', :default => true

      t.timestamps
    end
    add_index :shipment_methods, :store_id
    add_index :shipment_methods, :product_id
    add_column :products, "shipment_method_id", :string, :default => 0
  end

  def down
    drop_table :shipment_methods
  end
end
