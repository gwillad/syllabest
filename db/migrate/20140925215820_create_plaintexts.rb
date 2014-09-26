class CreatePlaintexts < ActiveRecord::Migration
  def change
    create_table :plaintexts do |t|
      t.string :title
      t.string :contents
      t.string :component_id

      t.timestamps
    end
  end
end
