class AddBorderPropertyToTables < ActiveRecord::Migration
  def change
  	add_column :tables, :border_class, :string
  end
end
