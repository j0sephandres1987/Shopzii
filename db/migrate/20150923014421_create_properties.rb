class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string 'name', :limit => 50, :null => false
      t.integer 'product_id', :default => 0
      t.timestamps
    end
    add_index :properties, :product_id
    add_column :products, "stock", :integer, :default => 0
  end
end
