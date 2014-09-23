class AddCourseNoDeptAndTerm < ActiveRecord::Migration
  def change
    add_column :syllabuses, :course_num, :string
    add_column :syllabuses, :department, :string
    add_column :syllabuses, :term, :string

    remove_column :syllabuses, :professor, :string
  end
end
