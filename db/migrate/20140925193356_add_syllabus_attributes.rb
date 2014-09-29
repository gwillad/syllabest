class AddSyllabusAttributes < ActiveRecord::Migration
  def change
  	add_column :syllabuses, :section_num, :string
  	add_column :syllabuses, :order, :string
  	add_column :syllabuses, :course_type, :string
  end
end
