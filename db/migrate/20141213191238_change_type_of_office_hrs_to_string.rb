class ChangeTypeOfOfficeHrsToString < ActiveRecord::Migration
  def change
    change_column :syllabuses, :office_hrs, :text
  end
end
