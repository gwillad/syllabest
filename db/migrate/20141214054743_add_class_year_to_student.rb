class AddClassYearToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :class_year, :string
  end
end
