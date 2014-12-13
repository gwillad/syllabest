class AddSyllabusToStudents < ActiveRecord::Migration
  def change
    add_column :students, :syllabus_id, :integer
  end
end
