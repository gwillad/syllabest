class AddOfficeHrsToSyllabus < ActiveRecord::Migration
  def change
    add_column :syllabuses, :office_hrs, :time
  end
end
