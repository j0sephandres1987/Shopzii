class AddPhotoColumnToProducts < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.integer "product_id", :default => 0
      t.timestamps
    end
    add_attachment :photos, :photo
    add_index :photos, :product_id
  end

  def down
    remove_attachment :photos, :photo
  end
end
