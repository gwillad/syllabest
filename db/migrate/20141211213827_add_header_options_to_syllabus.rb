class AddHeaderOptionsToSyllabus < ActiveRecord::Migration
  def change
  	add_column :syllabuses, :header_options, :boolean
  end
end
