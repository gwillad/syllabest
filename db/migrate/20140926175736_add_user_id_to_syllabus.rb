class AddUserIdToSyllabus < ActiveRecord::Migration
  def change
    add_column :syllabuses, :owner_id, :int
  end
end
