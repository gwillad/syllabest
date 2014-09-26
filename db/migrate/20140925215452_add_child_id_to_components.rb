class AddChildIdToComponents < ActiveRecord::Migration
  def change
    add_column :components, :child_id, :int
  end
end
