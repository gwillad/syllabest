class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :last_name
      t.string :first_name

      t.timestamps
    end
  end
end
