class RemoveOrderFromSyllabus < ActiveRecord::Migration
  def change
    remove_column :components, :order, :string
  end
end
