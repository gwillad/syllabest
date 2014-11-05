class AddOrderToSyllabus < ActiveRecord::Migration
  def change
    add_column :components, :order, :integer
  end
end
