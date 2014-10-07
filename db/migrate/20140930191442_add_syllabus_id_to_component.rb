class AddSyllabusIdToComponent < ActiveRecord::Migration
  def change
    add_column :components, :syllabus_id, :integer
  end
end
