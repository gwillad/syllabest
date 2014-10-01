class RemoveComponentName < ActiveRecord::Migration
  def change
    remove_column :components, :name, :string
  end
end
