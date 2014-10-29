class ChangeOwnerToUser < ActiveRecord::Migration
  def change
    rename_column :syllabuses, :owner_id, :user_id
  end
end
