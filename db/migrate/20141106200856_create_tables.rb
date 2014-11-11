class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :component_id
      t.text :contents
      t.integer :rows
      t.integer :columns
      t.string :title

      t.timestamps
    end
  end
end
