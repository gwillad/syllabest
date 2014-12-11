class ChangeHeaderOptionsToText < ActiveRecord::Migration
  def change
  	change_column :syllabuses, :header_options, :text
  end
end
