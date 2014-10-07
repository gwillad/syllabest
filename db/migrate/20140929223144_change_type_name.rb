class ChangeTypeName < ActiveRecord::Migration
  def change
    rename_column :components, :type, :component_type
  end
end
