class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string "name", :limit => 50, :null => false
      t.integer "collection_id", :default => 0
      t.integer "store_id", :default => 0
      t.boolean "status", :default => true
      
      t.timestamps
    end
    add_index :categories, :store_id
    add_index :categories, :collection_id
  end
end
