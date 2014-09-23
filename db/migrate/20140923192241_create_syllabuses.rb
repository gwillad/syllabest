class CreateSyllabuses < ActiveRecord::Migration
  def change
    create_table :syllabuses do |t|
      t.string :title
      t.string :location
      t.string :professor

      t.timestamps
    end
  end
end
