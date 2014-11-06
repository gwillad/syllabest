class RemoveChildIdFromComponent < ActiveRecord::Migration
  def change
    remove_column :components, :child_id, :integer
  end
end
