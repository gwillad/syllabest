class RemoveOrderStringFromSyllabus < ActiveRecord::Migration
  def change
    remove_column :syllabuses, :order, :string
  end
end
