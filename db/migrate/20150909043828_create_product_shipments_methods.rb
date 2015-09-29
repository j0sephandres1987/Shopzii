class CreateProductShipmentsMethods < ActiveRecord::Migration
  def up
    create_table :products_shipment_methods, :id => false do |t|
      t.integer "product_id"
      t.integer "shipment_method_id"
    end
    remove_column :products, :shipment_method_id
    remove_column :shipment_methods, :product_id
    add_index :products_shipment_methods, "product_id"
    add_index :products_shipment_methods, "shipment_method_id"
  end

  def down
    drop_table :products_shipment_methods
  end
end
