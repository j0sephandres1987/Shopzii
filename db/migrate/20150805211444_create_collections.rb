class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string "name", :limit => 50, :null => false
      t.integer "store_id", :default => 0
      t.boolean "status", :default => true
      
      t.timestamps
    end
    add_index :collections, :store_id
  end
end
