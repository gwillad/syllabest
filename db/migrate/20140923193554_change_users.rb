class ChangeUsers < ActiveRecord::Migration
  def change
    add_column :users, :office, :string
    add_column :users, :school, :string
  end
end
