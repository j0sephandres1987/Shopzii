class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string 'name', :limit => 50, :null => false
      t.integer 'property_id', :default => 0

      t.timestamps
    end
    add_index :values, :property_id
  end
end
