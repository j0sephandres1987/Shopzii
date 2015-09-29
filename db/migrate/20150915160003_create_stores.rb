class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string "name", :null => false
      t.integer "user_id", :default => 0
      t.boolean 'status', :default => true

      t.timestamps
    end
    add_index :stores, :user_id
  end
end
