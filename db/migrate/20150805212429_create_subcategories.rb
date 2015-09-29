class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string "name", :limit => 50, :null => false
      t.integer "category_id", :default => 0
      t.integer "store_id", :default => 0
      t.boolean "status", :default => true
      
      t.timestamps
    end
    add_index :subcategories, :store_id
    add_index :subcategories, :category_id
  end
end
