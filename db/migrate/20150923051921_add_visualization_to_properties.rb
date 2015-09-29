class AddVisualizationToProperties < ActiveRecord::Migration
  def change
    add_column :properties, "display_mode", :integer, :default => 0
  end
end
