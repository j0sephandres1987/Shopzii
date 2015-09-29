class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string 'name', :limit => 50, :null => false
      t.integer 'price', :default => 0
      t.text 'description'
      t.integer 'collection_id', :default => 0
      t.integer 'category_id', :default => 0
      t.integer 'subcategory_id', :default => 0
      t.integer 'store_id', :default => 0
      t.boolean 'status', :default => true

      t.timestamps
    end
    add_index :products, :collection_id
    add_index :products, :category_id
    add_index :products, :subcategory_id
    add_index :products, :store_id
    
  end
end
